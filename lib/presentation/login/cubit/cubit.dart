import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkin/presentation/login/cubit/state.dart';
import '../../../model/user_model.dart';
import '../../../shared/network/cache_helper.dart';

String? uId;

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stickerIdController = TextEditingController();

  void userRegister() async {
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      userCreate();
      emit(AuthRegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  void userCreate() {
    UserModel model = UserModel(
      name: nameController.text,
      email: emailController.text,
      type: false,
      uId: FirebaseAuth.instance.currentUser!.uid,
      stickerId: stickerIdController.text,
      image: '',
    );

    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .set(model.toJson())
        .then((value) {})
        .catchError((error) {
      print("fireStore error ${error.toString()}");
      emit(ErrorOccurred(error: error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      bool saveUId = await CacheHelper.saveData(
          key: "uId", value: FirebaseAuth.instance.currentUser!.uid);
      if (saveUId == true) {
        uId = FirebaseAuth.instance.currentUser!.uid;
        emit(UserLoginSuccess());
      }
      emit(UserLoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  late UserModel userModel;

  Future<void> getUserData() async {
    emit(AuthGetUserDataLoading());
    try {
      final result = await FirebaseFirestore.instance
          .collection('user')
          .where('uId', isEqualTo: uId)
          .get();
      userModel = UserModel.fromJson(result.docs.first.data());

      emit(AuthGetUserDataSuccess());
    } catch (e) {
      emit(AuthGetUserDataFailure(error: e.toString()));
    }
  }

  File? coverImage;
  late String imageUrl;
  final picker = ImagePicker();

  Future<void> getCoverImage() async {
    emit(AuthEditProfileGetImageLoading());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AuthEditProfileGetImageSuccess());
    } else {
      emit(AuthEditProfileGetImageFailure());
    }
  }

  Future<void> updateUserInfo() async {
    emit(AuthEditUserInfoLoading());
    if (coverImage == null) {
      try {
        await _updateUserData(updateImage: false);
        emit(AuthEditUserInfoSuccess());
      } catch (e) {
        emit(AuthEditUserInfoFailure(error: e.toString()));
      }
      return;
    }

    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) async {
        imageUrl = value;
        await _updateUserData(updateImage: true);
        emit(AuthEditUserInfoSuccess());
      }).catchError((error) {
        emit(AuthEditUserInfoFailure(error: error.toString()));
      });
    }).catchError((error) {
      emit(AuthEditUserInfoFailure(error: error.toString()));
    });
  }

  Future<void> _updateUserData({required bool updateImage}) async {
    final result = await FirebaseFirestore.instance
        .collection("user")
        .where('uId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final name = nameController.text;
    final email = emailController.text;
    final stickerId = stickerIdController.text;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(result.docs.first.id)
        .update({
      'name': name,
      'email': email,
      'stickerId': stickerId,
      if (updateImage) 'image': imageUrl,
    });
    if (email != userModel.email) {
      try {
        await FirebaseAuth.instance.currentUser!.updateEmail(email);
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          throw 'This email is invalid';
        }
        if (e.code == "email-already-in-use") {
          throw 'This email is already in use';
        }
        if (e.code == "requires-recent-login") {
          throw 'Changing email is a senstive operation we need you to be loged in recently';
        }
      }
    }
  }

  void logOut(BuildContext context) async {
    try {
      var x = await CacheHelper.removeData(key: 'uId');
      if (x == true) {
        if (context.mounted) {
          Phoenix.rebirth(context);
        }
        emit(MissionSuccess());
      } else {
        null;
      }
    } catch (error) {
      log(error.toString());
    }
  }
}

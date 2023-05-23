import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/model/user_model.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/shared/component/center_circular_progress_indicator.dart';
import 'package:parkin/shared/component/component.dart';

import '../../resources/assets_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/app_background.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({Key? key}) : super(key: key);

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late final UserModel user;
  @override
  void initState() {
    super.initState();
    user = AuthCubit.get(context).userModel;
    AuthCubit.get(context).nameController.text = user.name;
    AuthCubit.get(context).emailController.text = user.email;
    AuthCubit.get(context).stickerIdController.text = user.stickerId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthEditUserInfoSuccess) {
          Navigator.pop(context);
          showToast(msg: "Updated successfully", state: ToastStates.SUCCESS);
        }
        if (state is AuthEditUserInfoFailure) {
          showToast(msg: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.primary,
          body: AppBackground(
            physics: const BouncingScrollPhysics(),
            showAppBarIcons: true,
            customWidget: Column(
              children: [
                InkWell(
                  onTap: () {
                    AuthCubit.get(context).getCoverImage();
                  },
                  child: SizedBox(
                      height: responsive.sHeight(context) * .15,
                      width: responsive.sWidth(context) * .4,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: (AuthCubit.get(context)
                                              .coverImage !=
                                          null
                                      ? FileImage(
                                          AuthCubit.get(context).coverImage!)
                                      : user.image.isEmpty
                                          ? const AssetImage(
                                              ImageAssets.editProfile)
                                          : NetworkImage(user.image))
                                  as ImageProvider,
                            ),
                            if (user.image.isNotEmpty)
                              const CircleAvatar(
                                backgroundColor: ColorManager.primary,
                                radius: 20.0,
                                child: Icon(
                                  Icons.edit,
                                  size: 20.0,
                                  color: ColorManager.white,
                                ),
                              )
                          ],
                        ),
                      )),
                ),
                responsive.sizedBoxH30,
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return AppStrings.errorFieldMsg;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: AppStrings.name,
                  ),
                ),
                responsive.sizedBoxH10,
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return AppStrings.errorFieldMsg;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: AppStrings.email,
                  ),
                ),
                responsive.sizedBoxH10,
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return AppStrings.errorFieldMsg;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).stickerIdController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: AppStrings.stickerId,
                  ),
                ),
                responsive.sizedBoxH30,
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          AuthCubit.get(context).updateUserInfo();
                        },
                        child: state is AuthEditUserInfoLoading
                            ? const CenteredCircularProgressIndicator()
                            : const Text(AppStrings.update)))
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/model/reservation_model.dart';
import 'package:parkin/presentation/home%20screen/cubit/state.dart';
import '../../../model/parking_area_model.dart';
import '../../../resources/constant_maneger.dart';
import '../../home screen/home_screen.dart';
import '../../menu/menu_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const MenuScreen(),
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(NavigationBarChanged());
  }

  List<ParkingAreaModel> areas = [];
  Future<void> getParkingAreas() async {
    try {
      areas = [];
      emit(HomeGetParkingAreasLoading());
      final result = await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .get();

      if (areas.length != result.docs.length) {
        for (var element in result.docs) {
          areas.add(ParkingAreaModel.fromJson(element.data()));
        }
      }
      log(areas.toString());
      emit(HomeGetParkingAreasSuccess());
    } catch (e) {
      emit(HomeGetParkingAreasFailure(e.toString()));
    }
  }

  List<ReservationModel> reservations = [];
  Future<void> getMyReservations() async {
    reservations = [];
    emit(HomeGetUserReservationsLoading());
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .get();
      for (var element in result.docs) {
        final reservationsDoc = await FirebaseFirestore.instance
            .collection(AppConstant.parkingAreasCollectionName)
            .doc(element.id)
            .collection('reservations')
            .orderBy('startTime', descending: true)
            .get();

        for (var element in reservationsDoc.docs) {
          final reservation =
              ReservationModel.fromJson(element.data(), element.id);
          if (reservation.userId == FirebaseAuth.instance.currentUser!.uid) {
            final endTime = DateTime.parse(reservation.endTime);
            final startTime = DateTime.parse(reservation.startTime);
            final allowedTime = startTime.add(AppConstant.timerDuration);
            if (endTime.isAfter(DateTime.now()) &&
                (allowedTime.isAfter(DateTime.now()) ||
                    reservation.isReserved)) {
              reservations.add(reservation);
            } else {
              await removeReservation(reservation);
            }
          }
        }
      }
      log(areas.toString());
      emit(HomeGetUserReservationsSuccess());
    } catch (e) {
      emit(HomeGetUserReservationsFailure(e.toString()));
    }
  }

  ParkingAreaModel? parkingAreaModel;
  void changeSelectedAreaLocation(ParkingAreaModel parkingAreaModel) {
    this.parkingAreaModel = parkingAreaModel;
    emit(HomeChangeSelectedAreaLocation());
  }

  Future<void> removeReservation(ReservationModel reservationModel) async {
    final index = reservations.indexWhere(
      (element) => element.id == reservationModel.id,
    );
    try {
      if (index != -1) {
        reservations.removeAt(index);
      }
      await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .doc(reservationModel.parkingId)
          .collection('reservations')
          .doc(reservationModel.id)
          .delete();
      emit(HomeRemoveReservationSuccess());
    } catch (e) {
      reservations.insert(index, reservationModel);

      emit(HomeRemoveReservationFailure(error: e.toString()));
    }
  }
}

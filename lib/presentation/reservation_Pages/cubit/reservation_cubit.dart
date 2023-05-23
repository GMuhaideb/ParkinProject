// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/model/parking_area_model.dart';

import 'package:parkin/model/reservation_model.dart';
import 'package:parkin/presentation/login/cubit/cubit.dart';
import 'package:parkin/resources/constant_maneger.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit(
    this.parkingAreaModel,
  ) : super(ReservationInitial());
  static ReservationCubit get(BuildContext context) => BlocProvider.of(context);

  final ParkingAreaModel parkingAreaModel;
  String carType = "";
  int parkingArea = 0;
  int numberOfHoursIndex = 0;
  String numberOfHours = "1-3";

  void changeSelectedParkingArea(int index) {
    parkingArea = index;
    emit(ReservationChangeSelectedParkingArea());
  }

  void changeSelectedNumberOfHours(int index, String numberOfHours) {
    numberOfHoursIndex = index;
    this.numberOfHours = numberOfHours;
    emit(ReservationChangeSelectedNumberOfHours());
  }

  void setCarType(String carType) {
    this.carType = carType;
    emit(ReservationSetCarType());
  }

  Future<void> makeReservation() async {
    emit(ReservationMakeReservationLoading());
    final userId = FirebaseAuth.instance.currentUser!.uid;
    late int numOfHours;
    if (numberOfHours.contains('+')) {
      numOfHours = int.parse(numberOfHours.split('+')[0]);
    } else {
      numOfHours = int.parse(numberOfHours.split('-').length < 2
          ? numberOfHours.split('-')[0]
          : numberOfHours.split('-')[1]);
    }
    log(numOfHours.toString());
    final reservation = ReservationModel(
      userId: userId,
      parkingId: parkingAreaModel.id,
      carType: carType,
      parkingArea: parkingArea.toString(),
      numberOfHours: numberOfHours,
      isReserved: false,
      location: parkingAreaModel.location,
      startTime: DateTime.now().toIso8601String(),
      endTime:
          DateTime.now().add(Duration(hours: numOfHours)).toIso8601String(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .doc(parkingAreaModel.id)
          .collection('reservations')
          .add(reservation.toJson());
      emit(ReservationMakeReservationSuccess(
        reservationModel: reservation,
      ));
    } catch (e) {
      emit(ReservationMakeReservationFailure(error: e.toString()));
    }
  }

  Future<String?> isAlreadyReserved(String stickerId) async {
    final reservations = await FirebaseFirestore.instance
        .collection(AppConstant.parkingAreasCollectionName)
        .get();
    String? error;
    for (var element in reservations.docs) {
      log(element.id);
      bool isReserved = (await FirebaseFirestore.instance
              .collection(AppConstant.parkingAreasCollectionName)
              .doc(element.id)
              .collection('reservations')
              .where('userId', isEqualTo: uId)
              .get())
          .docs
          .isNotEmpty;
      if (isReserved) {
        error =
            "You're already have a reservation in ${element.data()['name']}";
        return error;
      }
    }
    return error;
  }

  Map<String, List<int>> parkingAreas = {};
  Future<void> getParkingAreas() async {
    parkingAreas = {};
    emit(ReservationGetParkingAreasLoading());
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .get();
      for (var element in result.docs) {
        final area = ParkingAreaModel.fromJson(element.data());
        parkingAreas[area.id] ??= [];
        final data = await FirebaseFirestore.instance
            .collection(AppConstant.parkingAreasCollectionName)
            .doc(element.id)
            .collection('reservations')
            .get();
        for (var reservationeElement in data.docs) {
          final reservation =
              ReservationModel.fromJson(reservationeElement.data(), element.id);
          parkingAreas[area.id]!.add(int.parse(reservation.parkingArea));
        }
      }
      emit(ReservationGetParkingAreasSuccess());
    } catch (e) {
      emit(ReservationGetParkingAreasFailure(e.toString()));
    }
  }
}

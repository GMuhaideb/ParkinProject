import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/model/parking_area_model.dart';
import 'package:parkin/model/reservation_model.dart';
import 'package:parkin/model/user_model.dart';
import 'package:parkin/resources/constant_maneger.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> upsertParkingArea(ParkingAreaModel parkingAreaModel) async {
    emit(AdminUpsertParkingAreaLoading());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .doc(parkingAreaModel.id)
          .set(parkingAreaModel.toJson());
      areas.map((area) {
        if (area.id == parkingAreaModel.id) {
          return parkingAreaModel;
        }
      });
      emit(AdminUpsertParkingAreaSuccess());
    } catch (e) {
      emit(AdminUpsertParkingAreaFailure(e.toString()));
    }
  }

  List<ParkingAreaModel> areas = [];
  Map<String, List<int>> parkingAreas = {};
  Map<String, Map<int, UserModel>> parkingAreasUsers = {};
  Future<void> getParkingAreas() async {
    areas = [];
    parkingAreas = {};
    parkingAreasUsers = {};
    emit(AdminGetParkingAreasLoading());
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .get();
      for (var element in result.docs) {
        final area = ParkingAreaModel.fromJson(element.data());
        areas.add(area);
        final data = await FirebaseFirestore.instance
            .collection(AppConstant.parkingAreasCollectionName)
            .doc(element.id)
            .collection('reservations')
            .get();
        for (var reservationeElement in data.docs) {
          final reservation =
              ReservationModel.fromJson(reservationeElement.data(), element.id);
          final user = UserModel.fromJson((await FirebaseFirestore.instance
                  .collection('user')
                  .where('uId', isEqualTo: reservation.userId)
                  .get())
              .docs
              .first
              .data());
          parkingAreas[area.id] ??= [];
          parkingAreas[area.id]!.add(int.parse(reservation.parkingArea));
          parkingAreasUsers[area.id] ??= {};
          parkingAreasUsers[area.id]![int.parse(reservation.parkingArea)] =
              user;
        }
      }
      emit(AdminGetParkingAreasSuccess());
    } catch (e) {
      emit(AdminGetParkingAreasFailure(e.toString()));
    }
  }

  Future<void> deleteParkingArea(ParkingAreaModel parkingAreaModel) async {
    emit(AdminDeleteParkingAreaLoading());
    int indexOfParkingArea =
        areas.indexWhere((element) => element.id == parkingAreaModel.id);
    try {
      areas.removeAt(indexOfParkingArea);
      await FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .doc(parkingAreaModel.id)
          .delete();
      var collection = FirebaseFirestore.instance
          .collection(AppConstant.parkingAreasCollectionName)
          .doc(parkingAreaModel.id)
          .collection('reservations');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
      emit(AdminDeleteParkingAreaSuccess());
    } catch (e) {
      areas.insert(indexOfParkingArea, parkingAreaModel);
      emit(AdminDeleteParkingAreaFailure(e.toString()));
    }
  }
}

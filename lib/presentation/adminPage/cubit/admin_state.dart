part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminUpsertParkingAreaLoading extends AdminState {}

class AdminUpsertParkingAreaSuccess extends AdminState {}

class AdminUpsertParkingAreaFailure extends AdminState {
  final String error;

  AdminUpsertParkingAreaFailure(this.error);
}

class AdminGetParkingAreasLoading extends AdminState {}

class AdminGetParkingAreasSuccess extends AdminState {}

class AdminGetParkingAreasFailure extends AdminState {
  final String error;

  AdminGetParkingAreasFailure(this.error);
}

class AdminDeleteParkingAreaLoading extends AdminState {}

class AdminDeleteParkingAreaSuccess extends AdminState {}

class AdminDeleteParkingAreaFailure extends AdminState {
  final String error;

  AdminDeleteParkingAreaFailure(this.error);
}

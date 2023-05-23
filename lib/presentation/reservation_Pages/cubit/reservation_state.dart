// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reservation_cubit.dart';

@immutable
abstract class ReservationState {}

class ReservationInitial extends ReservationState {}

class ReservationChangeSelectedParkingArea extends ReservationState {}

class ReservationChangeSelectedNumberOfHours extends ReservationState {}

class ReservationSetCarType extends ReservationState {}

class ReservationMakeReservationLoading extends ReservationState {}

class ReservationMakeReservationSuccess extends ReservationState {
  final ReservationModel reservationModel;
  ReservationMakeReservationSuccess({
    required this.reservationModel,
  });
}

class ReservationMakeReservationFailure extends ReservationState {
  final String error;
  ReservationMakeReservationFailure({
    required this.error,
  });
}

class ReservationGetParkingAreasLoading extends ReservationState {}

class ReservationGetParkingAreasSuccess extends ReservationState {}

class ReservationGetParkingAreasFailure extends ReservationState {
  final String error;

  ReservationGetParkingAreasFailure(this.error);
}

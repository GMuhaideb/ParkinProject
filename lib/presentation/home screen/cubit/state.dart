abstract class HomeState {}

class HomeInitialState extends HomeState {}

class ErrorOccurred extends HomeState {
  final String error;

  ErrorOccurred({required this.error});
}

class RemoveSuccess extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class GetSecurityParkingData extends HomeState {}

class DataLoading extends HomeState {}

class DataSuccess extends HomeState {}

class NavigationBarChanged extends HomeState {}

class EmptyParkingListSuccess extends HomeState {}

class HomeGetParkingAreasLoading extends HomeState {}

class HomeGetParkingAreasSuccess extends HomeState {}

class HomeGetParkingAreasFailure extends HomeState {
  final String error;

  HomeGetParkingAreasFailure(this.error);
}

class HomeGetUserReservationsLoading extends HomeState {}

class HomeGetUserReservationsSuccess extends HomeState {}

class HomeGetUserReservationsFailure extends HomeState {
  final String error;

  HomeGetUserReservationsFailure(this.error);
}

class HomeChangeSelectedAreaLocation extends HomeState {}

class HomeRemoveReservationSuccess extends HomeState {}

class HomeRemoveReservationFailure extends HomeState {
  final String error;
  HomeRemoveReservationFailure({
    required this.error,
  });
}

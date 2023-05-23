// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class ErrorOccurred extends AuthState {
  final String error;

  ErrorOccurred({required this.error});
}

class AuthRegisterSuccess extends AuthState {}

class AuthCreateSuccess extends AuthState {}

class UserLoginSuccess extends AuthState {}

class RemoveSuccess extends AuthState {}

class AuthLoading extends AuthState {}

class DataLoading extends AuthState {}

class DataSuccess extends AuthState {}

class NavigationBarChanged extends AuthState {}

class MissionSuccess extends AuthState {}

class EmptyParkingListSuccess extends AuthState {}

class AuthGetUserDataLoading extends AuthState {}

class AuthGetUserDataSuccess extends AuthState {}

class AuthGetUserDataFailure extends AuthState {
  final String error;
  AuthGetUserDataFailure({
    required this.error,
  });
}

class AuthEditProfileInitial extends AuthState {}

class AuthEditProfileGetImageLoading extends AuthState {}

class AuthEditProfileGetImageSuccess extends AuthState {}

class AuthEditProfileGetImageFailure extends AuthState {}

class AuthEditUserInfoLoading extends AuthState {}

class AuthEditUserInfoSuccess extends AuthState {}

class AuthEditUserInfoFailure extends AuthState {
  final String error;
  AuthEditUserInfoFailure({
    required this.error,
  });
}

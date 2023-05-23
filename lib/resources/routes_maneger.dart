import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/layout/app_layout.dart';
import 'package:parkin/model/parking_area_model.dart';
import 'package:parkin/model/reservation_model.dart';
import 'package:parkin/presentation/adminPage/screens/areas_screen.dart';
import 'package:parkin/presentation/adminPage/screens/parking_areas_screen.dart';
import 'package:parkin/presentation/adminPage/screens/upsert_parking_area.dart';
import 'package:parkin/presentation/after_launch/after_launch.dart';
import 'package:parkin/presentation/entered_parking_successfully/entered_parking_successfully_screen.dart';
import 'package:parkin/presentation/menu/menu_screen.dart';
import 'package:parkin/presentation/my_reservations/my_reservations.dart';
import 'package:parkin/presentation/profile/profile_screen.dart';
import 'package:parkin/presentation/reservation_Pages/cubit/reservation_cubit.dart';
import 'package:parkin/presentation/reservation_Pages/reservation_success/reservation_success_screen.dart';
import 'package:parkin/presentation/reservation_Pages/reserve_spot/reserve_spot_screen.dart';
import 'package:parkin/presentation/reservation_Pages/select_number_of_hours/select_number_of_hours_screen.dart';
import 'package:parkin/presentation/reservation_Pages/select_parking_area/select_parking_area_screen.dart';
import 'package:parkin/presentation/reservation_info/reservation_info_screen.dart';
import 'package:parkin/presentation/update_user/update_user_screen.dart';
import 'package:parkin/resources/strings_maneger.dart';
import '../../splash_screen/splash_screen.dart';

import '../model/parking_model.dart';
import '../presentation/adminPage/admin_page.dart';
import '../presentation/adminPage/screens/area_user_info.dart';
import '../presentation/home screen/home_screen.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/login/register_screen.dart';
import '../presentation/on_bording/on_boarding_screen.dart';
import '../presentation/parking_details/parking_details.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingScreen = "onBoardingScreen";
  static const String register = "register";
  static const String login = "login";
  static const String appLayout = "appLayout";
  static const String homeScreen = "/homeScreen";
  static const String afterLaunch = "/afterLaunch";
  static const String securityPage = "/securityPage";
  static const String parkingDetails = "/parkingDetails";
  static const String reserveSpot = "/reserve-spot";
  static const String selectParkingArea = "/select-parking-area";
  static const String parkingAreas = "/parking-areas";
  static const String selectNumberOfHours = "/select-number-of-hours";
  static const String reservationSuccess = "/reservation-success";
  static const String myReservations = "/my-reservation";
  static const String reservationInfo = "/reservation-info";
  static const String updateUser = "/update-user";
  static const String areas = "/areas";
  static const String upsertArea = "/upsert-area";
  static const String profile = "/profile";
  static const String areaUserInfo = "/area-user-info";
  static const String menu = "/menu";
  static const String enteredParkingSuccessfully =
      "/entered-parking-successfully";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.appLayout:
        return MaterialPageRoute(builder: (_) => const AppLayout());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.afterLaunch:
        return MaterialPageRoute(builder: (_) => const AfterLaunch());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.updateUser:
        return MaterialPageRoute(builder: (_) => const UpdateUserScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.securityPage:
        return MaterialPageRoute(builder: (_) => const AdminPage());
      case Routes.enteredParkingSuccessfully:
        return MaterialPageRoute(
            builder: (_) => const EnteredParkingSuccessfullyScreen());
      case Routes.menu:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(body: MenuScreen()));
      case Routes.parkingAreas:
        final parkingAreaModel = settings.arguments as ParkingAreaModel;
        return MaterialPageRoute(
            builder: (_) => ParkingAreasScreen(
                  parkingAreaModel: parkingAreaModel,
                ));
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.areaUserInfo:
        final list = settings.arguments as List<dynamic>;
        final parkingAreaModel = list[0] as ParkingAreaModel;
        final parkingAreaNumber = list[1] as int;

        return MaterialPageRoute(
            builder: (_) => AreaUserInfoScreen(
                  parkingAreaModel: parkingAreaModel,
                  parkingAreaNumber: parkingAreaNumber,
                ));
      case Routes.upsertArea:
        final area = settings.arguments as ParkingAreaModel?;
        return MaterialPageRoute(
            builder: (_) => UpsertParkingArea(
                  parkingAreaModel: area,
                ));
      case Routes.reserveSpot:
        final parkingAreaModel = settings.arguments as ParkingAreaModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ReservationCubit(parkingAreaModel),
                  child: const ReserveSpotScreen(),
                ));
      case Routes.selectParkingArea:
        final reservationCubit = settings.arguments as ReservationCubit;
        // final int numberOfAreas = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: reservationCubit,
                  child: const SelectParkingAreaScreen(),
                ));
      case Routes.selectNumberOfHours:
        final reservationCubit = settings.arguments as ReservationCubit;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: reservationCubit,
                  child: const SelectNumberOfHoursScreen(),
                ));
      case Routes.reservationSuccess:
        final reservation = settings.arguments as ReservationModel;
        return MaterialPageRoute(
            builder: (_) => ReservationSuccessScreen(
                  reservationModel: reservation,
                ));
      case Routes.areas:
        return MaterialPageRoute(builder: (_) => const AreasScreen());
      case Routes.myReservations:
        return MaterialPageRoute(builder: (_) => const MyReservationsScreen());
      case Routes.reservationInfo:
        final reservation = settings.arguments as ReservationModel;
        return MaterialPageRoute(
            builder: (_) => ReservationInfoScreen(
                  reservation: reservation,
                ));
      case Routes.parkingDetails:
        final parkingData = settings.arguments as ParkingModel;
        return MaterialPageRoute(
            builder: (_) => ParkingDetails(
                  parkingModel: parkingData,
                ));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings
                    .noRoutesFound), // todo move this string to strings manager
              ),
              body: const Center(
                  child: Text(AppStrings
                      .noRoutesFound)), // todo move this string to strings manager
            ));
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../presentation/login/cubit/cubit.dart';
import '../resources/assets_maneger.dart';
import '../resources/color_maneger.dart';
import '../resources/constant_maneger.dart';
import '../resources/responsive.dart';
import '../resources/routes_maneger.dart';
import '../shared/component/component.dart';
import '../shared/network/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  late String route;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstant.splashDelay), goNext);
  }

  goNext() async {
    uId = CacheHelper.getDate(key: 'uId');
    final isOnBoardingShown = CacheHelper.getDate(key: 'OnBoarding') ?? false;

    if (isOnBoardingShown) {
      if (uId != null) {
        await AuthCubit.get(context).getUserData();
        //Todo fix this == false
        if (context.mounted) {
          route = AuthCubit.get(context).userModel.type == false
              ? route = Routes.appLayout
              : route = Routes.securityPage;
        }
      } else {
        route = Routes.afterLaunch;
      }
    } else {
      route = Routes.onBoardingScreen;
    }
    if (context.mounted) {
      navigateToAndReplacement(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: responsive.sHeight(context) * .5,
              width: responsive.sWidth(context) * .8,
              child: Image.asset(ImageAssets.splashLogo),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
//test@test.com   => User
//kareem@kareem.com => Admin
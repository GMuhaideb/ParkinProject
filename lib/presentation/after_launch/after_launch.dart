import 'package:flutter/material.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/shared/component/component.dart';

import '../../resources/assets_maneger.dart';
import '../../resources/responsive.dart';

class AfterLaunch extends StatelessWidget {
  const AfterLaunch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: Column(
          children: [
            SizedBox(
              height: responsive.sHeight(context) * .5,
              width: responsive.sWidth(context) * .8,
              child: Image.asset(ImageAssets.splashLogo),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Reserving a Parking it’s become easy with us ! ',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            responsive.sizedBoxH30,
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  onPressed: () {
                    navigateToAndReplacement(context, Routes.login);
                  },
                  child: const Text('Log In')),
            ),
            responsive.sizedBoxH30,
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorManager.silver),
                  ),
                  onPressed: () {
                    navigateToAndReplacement(context, Routes.register);
                  },
                  child: const Text('Sign Up')),
            ),
          ],
        ));
  }
}

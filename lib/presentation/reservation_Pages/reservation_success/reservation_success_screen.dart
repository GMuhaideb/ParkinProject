// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:parkin/model/reservation_model.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/resources/routes_maneger.dart';

import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';

class ReservationSuccessScreen extends StatelessWidget {
  final ReservationModel reservationModel;
  const ReservationSuccessScreen({
    Key? key,
    required this.reservationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        showAppBarIcons: true,
        customWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thank you!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 32,
                    color: ColorManager.blue,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "you have successfully reserved your parking",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 32),
              ),
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.reservationInfo,
                      arguments: reservationModel);
                },
                child: const Text(AppStrings.ok),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

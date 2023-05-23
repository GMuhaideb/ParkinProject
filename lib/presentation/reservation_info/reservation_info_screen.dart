// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:parkin/model/reservation_model.dart';

import '../../resources/routes_maneger.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/app_background.dart';

class ReservationInfoScreen extends StatelessWidget {
  final ReservationModel reservation;
  ReservationInfoScreen({
    Key? key,
    required this.reservation,
  }) : super(key: key);
  final DateFormat format = DateFormat.yMMMMd();
  @override
  Widget build(BuildContext context) {
    log(reservation.carType);
    late String numberOfHours;
    if (reservation.numberOfHours.contains('+')) {
      numberOfHours = reservation.numberOfHours;
    } else {
      numberOfHours = reservation.numberOfHours.split('-')[1];
    }

    return Scaffold(
      body: AppBackground(
        showAppBarIcons: true,
        customWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Parking Lot of ${reservation.location}",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Text(
              "PARKING ZONE",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 22, color: ColorManager.grey),
            ),
            Text(
              "${reservation.parkingArea} Lot",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Text(
              "DURATION - DATE",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 22, color: ColorManager.grey),
            ),
            Text(
              "$numberOfHours HOURS - ${DateFormat.yMMMMd().format(DateTime.parse(reservation.endTime))}",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Center(
              child: QrImage(
                data: '''
                      Parking Lot of ${reservation.location},
                      PARKING ZONE: ${reservation.parkingArea} Lot,
                      DURATION - DATE: $numberOfHours HOURS - ${reservation.endTime}
                      ''',
                size: 200,
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
                      context, Routes.myReservations);
                },
                child: const Text(AppStrings.viewMyReservation),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

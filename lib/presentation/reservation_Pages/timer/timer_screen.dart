// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkin/model/reservation_model.dart';
import 'package:parkin/presentation/home%20screen/cubit/state.dart';
import 'package:parkin/resources/constant_maneger.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/resources/strings_maneger.dart';
import 'package:parkin/resources/value_maneger.dart';
import 'package:parkin/shared/component/component.dart';

import '../../../resources/color_maneger.dart';
import '../../home screen/cubit/cubit.dart';

class TimerReservationWidget extends StatefulWidget {
  final ReservationModel reservationModel;

  const TimerReservationWidget({
    Key? key,
    required this.reservationModel,
  }) : super(key: key);

  @override
  State<TimerReservationWidget> createState() => _TimerReservationWidgetState();
}

class _TimerReservationWidgetState extends State<TimerReservationWidget> {
  Timer? timer;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    duration = DateTime.parse(widget.reservationModel.startTime)
        .add(AppConstant.timerDuration)
        .difference(DateTime.now());
    startTimer();
    FirebaseFirestore.instance
        .collection(AppConstant.parkingAreasCollectionName)
        .doc(widget.reservationModel.parkingId)
        .collection('reservations')
        .doc(widget.reservationModel.id)
        .snapshots()
        .listen(
      (event) {
        if (event.data() != null && event.data()!['isReserved'] == "true") {
          final reservation =
              ReservationModel.fromJson(event.data()!, event.data()!['userId']);
          Navigator.pushReplacementNamed(
              context, Routes.enteredParkingSuccessfully);
        }
      },
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        timer?.cancel();
        HomeCubit.get(context).removeReservation(widget.reservationModel);
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final startTime = widget.reservationModel.startTime.split('T')[0];
    final startHour =
        "${DateTime.parse(widget.reservationModel.startTime).hour > 12 ? DateTime.parse(widget.reservationModel.startTime).hour - 12 : DateTime.parse(widget.reservationModel.startTime).hour}:${DateTime.parse(widget.reservationModel.startTime).minute}";

    final endTime = widget.reservationModel.endTime.split('T')[0];
    final endHour =
        "${DateTime.parse(widget.reservationModel.endTime).hour > 12 ? DateTime.parse(widget.reservationModel.endTime).hour - 12 : DateTime.parse(widget.reservationModel.endTime).hour}:${DateTime.parse(widget.reservationModel.endTime).minute}";
    return BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeRemoveReservationSuccess) {
            showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop(true);
                  });
                  return const AlertDialog(
                    title: CircleAvatar(
                      backgroundColor: ColorManager.primary,
                      radius: 20.0,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    content: Text(
                      AppStrings.reservationEndedSuccessfully,
                      textAlign: TextAlign.center,
                    ),
                  );
                });
          } else if (state is HomeRemoveReservationFailure) {
            showToast(
                msg: AppStrings.reservationEndedUnSuccessfully,
                state: ToastStates.ERROR);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.reservationModel.location,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                ),
                responsive.sizedBoxH20,
                CircleAvatar(
                  radius: 80,
                  backgroundColor: ColorManager.primary,
                  child: buildTime(),
                ),
                responsive.sizedBoxH50,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$startTime $startHour",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: AppSize.s14,
                            color: ColorManager.grey,
                          ),
                    ),
                    Text(
                      "$endTime $endHour",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: AppSize.s14,
                            color: ColorManager.grey,
                          ),
                    ),
                  ],
                ),
                responsive.sizedBoxH10,
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
                      openDialog();
                    },
                    child: const Text(AppStrings.endSession),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Center(
      child: Text(
        "00:$minutes:$seconds",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: AppSize.s30,
              color: ColorManager.white,
            ),
      ),
    );
  }

  bool isEndingReservation = false;

  void openDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsPadding: const EdgeInsets.only(bottom: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              iconPadding: EdgeInsets.zero,
              title: const Text(
                AppStrings.endSession,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text(
                AppStrings.areYouSure,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.lightBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(85, 48),
                    foregroundColor: ColorManager.lightBlack,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        )),
                    padding: const EdgeInsets.all(8.0),
                  ),
                  onPressed: () async {
                    setState(() {
                      isEndingReservation = true;
                    });
                    await HomeCubit.get(context)
                        .removeReservation(widget.reservationModel);
                    setState(() {
                      isEndingReservation = false;
                    });
                    timer?.cancel();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(85, 48),
                    foregroundColor: ColorManager.lightBlack,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(8.0),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          });
        });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

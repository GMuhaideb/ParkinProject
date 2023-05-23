import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/presentation/reservation_Pages/cubit/reservation_cubit.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/shared/component/center_circular_progress_indicator.dart';
import 'package:parkin/shared/component/component.dart';

import '../../../resources/color_maneger.dart';
import '../../../resources/responsive.dart';
import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';

class SelectNumberOfHoursScreen extends StatelessWidget {
  const SelectNumberOfHoursScreen({super.key});

  final availableHours = const ['1-3', '4-6', '7-9', '10+'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationCubit, ReservationState>(
      listener: (context, state) {
        if (state is ReservationMakeReservationSuccess) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: AlertDialog(
                    title: const Text(
                      "Note",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      AppStrings.youHaveFifteenMinutes,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    actions: [
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.of(context).pushNamed(
                                Routes.reservationSuccess,
                                arguments: state.reservationModel);
                          },
                          child: const Text(
                            "Ok",
                            style: TextStyle(
                              color: ColorManager.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        } else if (state is ReservationMakeReservationFailure) {
          showToast(msg: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AppBackground(
            showAppBarIcons: true,
            customWidget: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  AppStrings.selectNumberOfAreas,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: responsive.sHeight(context) * 0.5,
                  width: responsive.sWidth(context) * 0.3,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, i) => SizedBox(
                      child: ElevatedButton(
                          onPressed: () {
                            ReservationCubit.get(context)
                                .changeSelectedNumberOfHours(
                                    i, availableHours[i]);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ReservationCubit.get(context)
                                        .numberOfHoursIndex ==
                                    i
                                ? ColorManager.primary
                                : Colors.grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  availableHours[i],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const Text(
                                  'hours',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          )),
                    ),
                    separatorBuilder: (context, i) => const SizedBox(
                      height: 40,
                    ),
                    itemCount: availableHours.length,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: responsive.sWidth(context) * 0.5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 12.0,
                          ),
                        ),
                        onPressed: () {
                          ReservationCubit.get(context).makeReservation();
                        },
                        child: state is ReservationMakeReservationLoading
                            ? const CenteredCircularProgressIndicator()
                            : const Text(AppStrings.confirm)))
              ],
            ),
          ),
        );
      },
    );
  }
}

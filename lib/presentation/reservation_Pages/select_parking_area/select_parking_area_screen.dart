import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/presentation/reservation_Pages/cubit/reservation_cubit.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/shared/component/center_circular_progress_indicator.dart';

import '../../../resources/responsive.dart';
import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';

class SelectParkingAreaScreen extends StatefulWidget {
  const SelectParkingAreaScreen({super.key});

  @override
  State<SelectParkingAreaScreen> createState() =>
      _SelectParkingAreaScreenState();
}

class _SelectParkingAreaScreenState extends State<SelectParkingAreaScreen> {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();
    ReservationCubit.get(context).getParkingAreas();
  }

  @override
  Widget build(BuildContext context) {
    final area = ReservationCubit.get(context).parkingAreaModel;
    return BlocBuilder<ReservationCubit, ReservationState>(
      builder: (context, state) {
        if (state is ReservationGetParkingAreasLoading) {
          return const Scaffold(body: CenteredCircularProgressIndicator());
        }
        if (state is ReservationGetParkingAreasFailure) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        }

        return Scaffold(
          body: AppBackground(
            showAppBarIcons: true,
            customWidget: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  AppStrings.selectParkingArea,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: responsive.sHeight(context) * 0.5,
                  child: ListView.separated(
                    itemBuilder: (context, i) {
                      final textOfLeftButtons = i + 1;
                      final textOfRightButtons = ((area.number % 2 != 0)
                              ? area.number ~/ 2 + 1
                              : area.number ~/ 2) +
                          (i + 1);
                      final isAreasNumberEven = area.number % 2 == 0;
                      final isAreasNumberOdd = area.number % 2 != 0;
                      final areWeAtTheIndexOfButtonThatShouldntAppearBecaseAreasNumberIsOdd =
                          i != area.number ~/ 2;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: responsive.sWidth(context) * 0.3,
                            child: ElevatedButton(
                              onPressed: () {
                                if (ReservationCubit.get(context)
                                    .parkingAreas[area.id]!
                                    .contains(textOfLeftButtons)) {
                                  return;
                                }
                                ReservationCubit.get(context)
                                    .changeSelectedParkingArea(
                                        textOfLeftButtons);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (ReservationCubit.get(context)
                                                .parkingArea ==
                                            (textOfLeftButtons) ||
                                        ReservationCubit.get(context)
                                            .parkingAreas[area.id]!
                                            .contains(textOfLeftButtons))
                                    ? ColorManager.primary
                                    : Colors.grey,
                              ),
                              child: Text(
                                twoDigits(textOfLeftButtons),
                              ),
                            ),
                          ),
                          if ((isAreasNumberOdd &&
                                  areWeAtTheIndexOfButtonThatShouldntAppearBecaseAreasNumberIsOdd) ||
                              isAreasNumberEven) ...[
                            //show this at the top only
                            if (i == 0)
                              Column(
                                children: const [
                                  Text(
                                    'Entry',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Icon(
                                    Icons.arrow_downward,
                                    size: 30,
                                  )
                                ],
                              )
                            //otherwise show this
                            else
                              const SizedBox(
                                height: 40.0,
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 2.0,
                                  width: 1.0,
                                ),
                              ),
                            SizedBox(
                              width: responsive.sWidth(context) * 0.3,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (ReservationCubit.get(context)
                                      .parkingAreas[area.id]!
                                      .contains(textOfRightButtons)) {
                                    return;
                                  }
                                  ReservationCubit.get(context)
                                      .changeSelectedParkingArea(
                                          (textOfRightButtons));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      (ReservationCubit.get(context)
                                                      .parkingArea ==
                                                  textOfRightButtons ||
                                              ReservationCubit.get(context)
                                                  .parkingAreas[area.id]!
                                                  .contains(textOfRightButtons))
                                          ? ColorManager.primary
                                          : Colors.grey,
                                ),
                                child: Text(
                                  twoDigits(textOfRightButtons),
                                ),
                              ),
                            ),
                          ]
                        ],
                      );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                      height: i == 0 ? 25 : 30,
                    ),
                    // if areas number is odd we need to add one to the half of it why ?
                    // __  __
                    // __
                    //here as you can see if we have 3 areas (the half of it as integer =  1) and we know at each level there is two
                    // so we need extra level for the last one
                    // otherwise if it's only two  so we will take the half of it
                    itemCount: (area.number % 2 != 0)
                        ? area.number ~/ 2 + 1
                        : area.number ~/ 2,
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
                        onPressed: ReservationCubit.get(context).parkingArea ==
                                0
                            ? null
                            : () {
                                Navigator.of(context).pushNamed(
                                    Routes.selectNumberOfHours,
                                    arguments: ReservationCubit.get(context));
                              },
                        child: const Text(AppStrings.next)))
              ],
            ),
          ),
        );
      },
    );
  }
}

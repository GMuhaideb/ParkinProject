// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parkin/model/parking_area_model.dart';
import 'package:parkin/resources/color_maneger.dart';

import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/shared/component/component.dart';

import '../../../resources/responsive.dart';
import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';
import '../cubit/admin_cubit.dart';

class ParkingAreasScreen extends StatelessWidget {
  final ParkingAreaModel parkingAreaModel;
  const ParkingAreasScreen({
    Key? key,
    required this.parkingAreaModel,
  }) : super(key: key);
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    log(AdminCubit.get(context).parkingAreasUsers.toString());
    log(AdminCubit.get(context).parkingAreas[parkingAreaModel.id].toString());
    int numberOfAreas = parkingAreaModel.number;
    return Scaffold(
      body: AppBackground(
        showAppBarIcons: true,
        shoTrailingIcon: true,
        customWidget: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              AppStrings.parkingArea,
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
                  final textOfRightButtons = ((numberOfAreas % 2 != 0)
                          ? numberOfAreas ~/ 2 + 1
                          : numberOfAreas ~/ 2) +
                      (i + 1);
                  final isAreasNumberEven = numberOfAreas % 2 == 0;
                  final isAreasNumberOdd = numberOfAreas % 2 != 0;
                  final areWeAtTheIndexOfButtonThatShouldntAppearBecaseAreasNumberIsOdd =
                      i != numberOfAreas ~/ 2;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: responsive.sWidth(context) * 0.3,
                        child: ElevatedButton(
                          onPressed: () {
                            log(parkingAreaModel.id);
                            log(AdminCubit.get(context)
                                    .parkingAreasUsers[parkingAreaModel.id]
                                        ?[textOfLeftButtons]
                                    .toString() ??
                                "65415645dfd");
                            if (AdminCubit.get(context)
                                        .parkingAreasUsers[parkingAreaModel.id]
                                    ?[textOfLeftButtons] !=
                                null) {
                              navigateTo(context, Routes.areaUserInfo,
                                  arguments: [
                                    parkingAreaModel,
                                    textOfLeftButtons
                                  ]);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                (AdminCubit.get(context).parkingAreas[
                                                parkingAreaModel.id] !=
                                            null &&
                                        AdminCubit.get(context)
                                            .parkingAreas[parkingAreaModel.id]!
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
                              if (AdminCubit.get(context).parkingAreasUsers[
                                          parkingAreaModel.id]
                                      ?[textOfRightButtons] !=
                                  null) {
                                navigateTo(context, Routes.areaUserInfo,
                                    arguments: [
                                      parkingAreaModel,
                                      textOfRightButtons
                                    ]);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (AdminCubit.get(context)
                                                  .parkingAreas[
                                              parkingAreaModel.id] !=
                                          null &&
                                      AdminCubit.get(context)
                                          .parkingAreas[parkingAreaModel.id]!
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
                itemCount: (numberOfAreas % 2 != 0)
                    ? numberOfAreas ~/ 2 + 1
                    : numberOfAreas ~/ 2,
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
                  Navigator.pushNamed(
                    context,
                    Routes.upsertArea,
                    arguments: parkingAreaModel,
                  );
                },
                child: const Text(AppStrings.update),
              ),
            )
          ],
        ),
      ),
    );
  }
}

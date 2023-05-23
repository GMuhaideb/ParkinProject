import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/model/parking_area_model.dart';
import 'package:parkin/presentation/adminPage/cubit/admin_cubit.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/shared/component/center_circular_progress_indicator.dart';
import 'package:parkin/shared/component/component.dart';

import '../../../resources/color_maneger.dart';
import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';

class AreasScreen extends StatefulWidget {
  const AreasScreen({super.key});

  @override
  State<AreasScreen> createState() => _AreasScreenState();
}

class _AreasScreenState extends State<AreasScreen> {
  @override
  void initState() {
    super.initState();
    AdminCubit.get(context).getParkingAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        showAppBarIcons: true,
        customWidget: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            if (state is AdminGetParkingAreasLoading) {
              return const CenteredCircularProgressIndicator(
                color: ColorManager.primary,
              );
            } else if (state is AdminGetParkingAreasFailure) {
              return Center(
                child: Text(
                  state.error,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              );
            }
            final areas = AdminCubit.get(context).areas;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                responsive.sizedBoxH10,
                SizedBox(
                  height: responsive.sHeight(context) * 0.5,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, i) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10.0)),
                      onLongPress: () {
                        openDialog(areas[i]);
                      },
                      onPressed: () {
                        navigateTo(context, Routes.parkingAreas,
                            arguments: areas[i]);
                      },
                      child: Text(
                        areas[i].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    separatorBuilder: (context, i) => responsive.sizedBoxH15,
                    itemCount: areas.length,
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
                      Navigator.pushNamed(context, Routes.upsertArea).then(
                          (value) => AdminCubit.get(context).getParkingAreas());
                    },
                    child: const Text(AppStrings.add),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            );
          },
        ),
      ),
    );
  }

  bool isDeleting = false;
  void openDialog(ParkingAreaModel parkingAreaModel) {
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
              title: isDeleting
                  ? null
                  : const Text(
                      AppStrings.areYouSure,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              content: isDeleting
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CenteredCircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ],
                    )
                  : const Text(
                      AppStrings.deleteParkingArea,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorManager.lightBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: isDeleting
                  ? null
                  : [
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
                            isDeleting = true;
                          });
                          await AdminCubit.get(context)
                              .deleteParkingArea(parkingAreaModel);
                          setState(() {
                            isDeleting = false;
                          });
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          "Delete",
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
}

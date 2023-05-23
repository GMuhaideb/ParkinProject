import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/model/parking_area_model.dart';
import 'package:parkin/presentation/home%20screen/cubit/cubit.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/shared/component/app_background.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/center_circular_progress_indicator.dart';
import '../../shared/component/component.dart';
import '../login/cubit/cubit.dart';
import 'cubit/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getParkingAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary,
        body: AppBackground(
          customWidget: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeGetParkingAreasLoading) {
                  return const CenteredCircularProgressIndicator(
                    color: ColorManager.primary,
                  );
                } else if (state is HomeGetParkingAreasFailure) {
                  return Center(
                    child: Text(
                      state.error,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  );
                }
                final areas = HomeCubit.get(context).areas;
                if (areas.isEmpty) {
                  return Center(
                    child: Text(
                      "No Areas Available",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: ColorManager.primary),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await HomeCubit.get(context).getParkingAreas();
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Text(
                        AppStrings.chooseParking,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 20),
                      ),
                      responsive.sizedBoxH20,
                      SizedBox(
                        width: double.infinity,
                        child: Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: 5,
                          child: DropdownButton<ParkingAreaModel>(
                            alignment: Alignment.center,
                            isExpanded: true,
                            value: HomeCubit.get(context).parkingAreaModel ??
                                areas[0],
                            items: areas
                                .map(
                                  (e) => DropdownMenuItem<ParkingAreaModel>(
                                    value: e,
                                    alignment: Alignment.center,
                                    child: Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              HomeCubit.get(context)
                                  .changeSelectedAreaLocation(value!);
                            },
                          ),
                        ),
                      ),
                      responsive.sizedBoxH10,
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.profile);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                                responsive.sizedBoxW5,
                                Text(
                                  'hello ${AuthCubit.get(context).userModel.name}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH10,
                      InkWell(
                        onTap: () {
                          navigateTo(context, Routes.myReservations);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.airplane_ticket,
                                  size: 30,
                                ),
                                responsive.sizedBoxW5,
                                Text(
                                  'Ticket',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      responsive.sizedBoxH15,
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "P",
                            style: TextStyle(
                                color: ColorManager.white, fontSize: 70),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: areas.isEmpty
                            ? null
                            : () {
                                Navigator.pushNamed(context, Routes.reserveSpot,
                                    arguments: HomeCubit.get(context)
                                            .parkingAreaModel ??
                                        areas[0]);
                              },
                        child: const Text("Reserve a Spot"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}

//
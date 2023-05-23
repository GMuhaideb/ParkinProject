import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/presentation/home%20screen/cubit/cubit.dart';
import 'package:parkin/presentation/reservation_Pages/timer/timer_screen.dart';
import 'package:parkin/shared/component/center_circular_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../resources/color_maneger.dart';
import '../../../resources/responsive.dart';
import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';
import '../home screen/cubit/state.dart';

class MyReservationsScreen extends StatefulWidget {
  const MyReservationsScreen({super.key});

  @override
  State<MyReservationsScreen> createState() =>
      _ReservationEndedSuccessfullyScreenState();
}

class _ReservationEndedSuccessfullyScreenState
    extends State<MyReservationsScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getMyReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        showAppBarIcons: true,
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                AppStrings.myReservations,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 20,
                      color: ColorManager.darkBlue,
                    ),
              ),
              responsive.sizedBoxH30,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeGetUserReservationsLoading) {
                    return const CenteredCircularProgressIndicator(
                      color: ColorManager.primary,
                    );
                  } else if (state is HomeGetUserReservationsFailure) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  final reservations = HomeCubit.get(context).reservations;

                  return Column(
                    children: [
                      if (reservations.isEmpty) ...[
                        SizedBox(
                          height: responsive.sHeight(context) * 0.3,
                        ),
                        Text(
                          AppStrings.noReservation,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 20,
                                    color: ColorManager.grey,
                                  ),
                        ),
                      ],
                      RefreshIndicator(
                        onRefresh: () async {
                          await HomeCubit.get(context).getMyReservations();
                        },
                        child: SizedBox(
                          height: responsive.sHeight(context) * 0.6,
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse(
                                            "https://goo.gl/maps/BmtGwRbA5YBvt8Ar9"),
                                      );
                                    },
                                    child: Material(
                                      elevation: 10.0,
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                  Icons.location_on_outlined),
                                              Text(
                                                reservations[i].location,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  responsive.sizedBoxH30,
                                  if (reservations[i].isReserved)
                                    Material(
                                      elevation: 10.0,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Location: ${reservations[i].location}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              responsive.sizedBoxH10,
                                              Text(
                                                'Area: ${reservations[i].parkingArea}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              responsive.sizedBoxH10,
                                              Text(
                                                'Hours: ${reservations[i].numberOfHours}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              responsive.sizedBoxH10,
                                              Text(
                                                'StickerId: ${reservations[i].carType}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ]),
                                      ),
                                    )
                                  else
                                    TimerReservationWidget(
                                      reservationModel: reservations[i],
                                    ),
                                ],
                              );
                            },
                            separatorBuilder: (context, i) =>
                                responsive.sizedBoxH20,
                            itemCount: reservations.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

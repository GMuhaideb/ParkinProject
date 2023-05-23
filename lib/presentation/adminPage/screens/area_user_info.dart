// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:parkin/model/parking_area_model.dart';
import 'package:parkin/presentation/adminPage/cubit/admin_cubit.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/shared/component/app_background.dart';

class AreaUserInfoScreen extends StatelessWidget {
  final ParkingAreaModel parkingAreaModel;
  final int parkingAreaNumber;
  const AreaUserInfoScreen({
    Key? key,
    required this.parkingAreaModel,
    required this.parkingAreaNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parkingAreasUsers = AdminCubit.get(context).parkingAreasUsers;
    final user = parkingAreasUsers[parkingAreaModel.id]![parkingAreaNumber]!;
    return Scaffold(
      body: AppBackground(
          showAppBarIcons: true,
          customWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (user.image.isNotEmpty)
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(user.image),
                    )
                  else
                    const CircleAvatar(
                      radius: 30.0,
                      child: Icon(Icons.edit),
                    ),
                  responsive.sizedBoxW25,
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              responsive.sizedBoxH30,
              infoText(context, "StickerId: ", user.stickerId),
              responsive.sizedBoxH20,
              infoText(context, "Email: ", user.email),
              responsive.sizedBoxH20,
              infoText(context, "Location: ", parkingAreaModel.location),
              responsive.sizedBoxH20,
              infoText(context, "Area Name: ", parkingAreaModel.name),
            ],
          )),
    );
  }

  Widget infoText(BuildContext context, String title, text) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

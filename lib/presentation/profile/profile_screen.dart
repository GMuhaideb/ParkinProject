import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/presentation/login/cubit/cubit.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/shared/component/app_background.dart';
import 'package:parkin/shared/component/component.dart';

import '../login/cubit/state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final user = AuthCubit.get(context).userModel;
        final firstTwoCharsOfName = user.name.split(' ')[0][0] +
            (user.name.split(' ').length < 2 ? '' : user.name.split(' ')[1][0]);
        return Scaffold(
          body: AppBackground(
            showAppBarIcons: true,
            customWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(color: ColorManager.primary, fontSize: 20),
                ),
                responsive.sizedBoxH50,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorManager.primary,
                      radius: 30,
                      child: Text(
                        firstTwoCharsOfName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    responsive.sizedBoxW25,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user.stickerId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.grey2,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                responsive.sizedBoxH40,
                InkWell(
                  onTap: () {
                    navigateTo(context, Routes.myReservations);
                  },
                  child: Material(
                    elevation: 10.0,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          responsive.sizedBoxW15,
                          const Text(
                            "My Resesrvations",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  ),
                ),
                responsive.sizedBoxH50,
                InkWell(
                  onTap: () {
                    navigateTo(context, Routes.updateUser)
                        .then((value) => AuthCubit.get(context).getUserData());
                  },
                  child: Material(
                    elevation: 10.0,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.edit),
                          responsive.sizedBoxW15,
                          const Text(
                            "Edit profile",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/resources/font_maneger.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/shared/component/app_background.dart';
import '../../resources/color_maneger.dart';
import '../../resources/routes_maneger.dart';
import '../../resources/strings_maneger.dart';
import '../home screen/cubit/cubit.dart';
import '../home screen/cubit/state.dart';
import '../login/cubit/cubit.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController addCarNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: BlocConsumer<HomeCubit, HomeState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            if (state is DataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorOccurred) {
              return const Text(AppStrings.errorMsg);
            }

            return AppBackground(
              shoTrailingIcon: true,
              customWidget: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Welcome admin",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    responsive.sizedBoxH50,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.areas);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                child: Text(
                                  "P",
                                  style: TextStyle(
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            responsive.sizedBoxW25,
                            Text(
                              "Areas",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontSize: FontSize.s25),
                            ),
                          ]),
                    ),
                    responsive.sizedBoxH50,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 8,
                          ),
                        ),
                        onPressed: () {
                          AuthCubit.get(context).logOut(context);
                        },
                        child: Text(
                          "LOGOUT",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  color: Colors.white, fontSize: FontSize.s25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

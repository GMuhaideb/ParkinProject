import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/resources/strings_maneger.dart';
import 'package:parkin/shared/component/app_background.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';
import '../../shared/component/component.dart';
import '../../shared/network/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late String route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, state) {
          if (state is UserLoginSuccess) {
            uId = CacheHelper.getDate(key: 'uId');
            AuthCubit.get(context).getUserData().then((value) {
              route = AuthCubit.get(context).userModel.type == false
                  ? route = Routes.appLayout
                  : route = Routes.securityPage;
              Navigator.pushNamedAndRemoveUntil(
                  context, route, (route) => false);
              showToast(
                  msg: 'login success', state: ToastStates.SUCCESS);
            });
          }
          if (state is ErrorOccurred) {
            if (state.error.isNotEmpty) {
              showToast(msg: state.error, state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) => Form(
            key: formState,
            child: AppBackground(
              physics: const BouncingScrollPhysics(),
              customWidget: Column(
                children: [
                  responsive.sizedBoxH30,
                  const Text(
                    AppStrings.login,
                    style: TextStyle(fontSize: 30),
                  ),
                  responsive.sizedBoxH30,
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppStrings.errorFieldMsg;
                      }
                      return null;
                    },
                    controller: AuthCubit.get(context).emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: AppStrings.email,
                    ),
                  ),
                  responsive.sizedBoxH15,
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppStrings.errorFieldMsg;
                      }
                      return null;
                    },
                    controller: AuthCubit.get(context).passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      hintText: AppStrings.password,
                    ),
                  ),
                  responsive.sizedBoxH30,
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text(AppStrings.login),
                        onPressed: () {
                          if (formState.currentState!.validate()) {
                            AuthCubit.get(context).userLogin(
                                email:
                                    AuthCubit.get(context).emailController.text,
                                password: AuthCubit.get(context)
                                    .passwordController
                                    .text);
                          }
                        },
                      )),
                  responsive.sizedBoxH30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an account?"),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, Routes.register);
                          },
                          child: const Text(
                            AppStrings.register,
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

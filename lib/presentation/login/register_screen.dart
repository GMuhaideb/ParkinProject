import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/shared/component/app_background.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';
import '../../resources/strings_maneger.dart';
import '../../shared/component/component.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, state) {
          if (state is AuthRegisterSuccess) {
            navigateToAndReplacement(context, Routes.login);
            showToast(msg: 'register success', state: ToastStates.SUCCESS);
          }
          if (state is ErrorOccurred) {
            if (state.error.isNotEmpty) {
              showToast(msg: state.error, state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) => Form(
          key: formKey,
          child: AppBackground(
            physics: const BouncingScrollPhysics(),
            customWidget: Column(
              children: [
                const Text(
                  AppStrings.register,
                  style: TextStyle(fontSize: 30),
                ),
                responsive.sizedBoxH30,
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorFieldMsg;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).nameController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.name,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return AppStrings.errorFieldMsg;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).emailController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.email,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorFieldMsg;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).stickerIdController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.stickerId,
                  ),
                ),
                responsive.sizedBoxH10,
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return AppStrings.errorFieldMsg;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).passwordController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.password,
                  ),
                ),
                responsive.sizedBoxH10,
                TextFormField(
                  validator: (val) {
                    if (val != AuthCubit.get(context).passwordController.text) {
                      return AppStrings.notMatched;
                    }
                    return null;
                  },
                  controller: AuthCubit.get(context).rePasswordController,
                  decoration: const InputDecoration(
                    hintText: AppStrings.re_password,
                  ),
                ),
                responsive.sizedBoxH20,
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AuthCubit.get(context).userRegister();
                      } else {
                        return;
                      }
                    },
                    child: const Text(
                      AppStrings.register,
                    ),
                  ),
                ),
                responsive.sizedBoxH30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        navigateTo(context, Routes.login);
                      },
                      child: const Text(
                        AppStrings.login,
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

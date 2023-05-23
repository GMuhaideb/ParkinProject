import 'package:flutter/material.dart';
import 'package:parkin/presentation/login/cubit/cubit.dart';
import 'package:parkin/presentation/reservation_Pages/cubit/reservation_cubit.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/resources/strings_maneger.dart';
import 'package:parkin/shared/component/app_background.dart';
import 'package:parkin/shared/component/build_text_form.dart';
import 'package:parkin/shared/component/component.dart';

class ReserveSpotScreen extends StatefulWidget {
  const ReserveSpotScreen({super.key});

  @override
  State<ReserveSpotScreen> createState() => _ReserveSpotScreenState();
}

class _ReserveSpotScreenState extends State<ReserveSpotScreen> {
  final _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        showAppBarIcons: true,
        customWidget: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 12.0,
                    ),
                  ),
                  onPressed: () async {
                    final error = await ReservationCubit.get(context)
                        .isAlreadyReserved(_textEditingController.text);
                    if (error != null) {
                      showToast(
                        msg: error,
                        state: ToastStates.ERROR,
                      );
                      return;
                    }
                    if (context.mounted) {
                      ReservationCubit.get(context).setCarType(
                          AuthCubit.get(context).userModel.stickerId);
                      Navigator.of(context).pushNamed(Routes.selectParkingArea,
                          arguments: ReservationCubit.get(context));
                    }
                  },
                  child: const Text(AppStrings.nextWithStickerId),
                ),
              ),
              const SizedBox(height: 50.0),
              Text(
                AppStrings.enterYourCarStickerId,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 20),
              BuildTextForm(
                title: AppStrings.stickerId,
                hintText: "Enter your car's stickerId",
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Car's type can't be empty";
                  }
                  return null;
                },
                controller: _textEditingController,
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: responsive.sWidth(context) * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 12.0,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final error = await ReservationCubit.get(context)
                          .isAlreadyReserved(_textEditingController.text);
                      if (error != null) {
                        showToast(
                          msg: error,
                          state: ToastStates.ERROR,
                        );
                        return;
                      }
                      if (context.mounted) {
                        ReservationCubit.get(context)
                            .setCarType(_textEditingController.text);
                        _textEditingController.clear();
                        Navigator.of(context).pushNamed(
                            Routes.selectParkingArea,
                            arguments: ReservationCubit.get(context));
                      }
                    }
                  },
                  child: const Text(AppStrings.next),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

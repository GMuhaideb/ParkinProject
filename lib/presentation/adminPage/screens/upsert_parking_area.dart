// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkin/model/parking_area_model.dart';
import 'package:parkin/presentation/adminPage/cubit/admin_cubit.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/shared/component/center_circular_progress_indicator.dart';
import 'package:parkin/shared/component/component.dart';

import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';
import '../../../shared/component/build_text_form.dart';

class UpsertParkingArea extends StatefulWidget {
  final ParkingAreaModel? parkingAreaModel;
  const UpsertParkingArea({
    Key? key,
    this.parkingAreaModel,
  }) : super(key: key);

  @override
  State<UpsertParkingArea> createState() => _UpsertParkingAreaState();
}

class _UpsertParkingAreaState extends State<UpsertParkingArea> {
  final _areaNameController = TextEditingController();
  final _areaNumberController = TextEditingController();
  final _areaLocationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.parkingAreaModel != null) {
      _areaNameController.text = widget.parkingAreaModel!.name;
      _areaNumberController.text = widget.parkingAreaModel!.number.toString();
      _areaLocationController.text = widget.parkingAreaModel!.location;
    }
  }

  @override
  void dispose() {
    _areaLocationController.dispose();
    _areaNameController.dispose();
    _areaNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminUpsertParkingAreaSuccess) {
          Navigator.popUntil(context, (route) {
            return route.isFirst;
          });
          showToast(
              msg:
                  '${widget.parkingAreaModel == null ? 'Addedd' : 'Updated'} Successfully',
              state: ToastStates.SUCCESS);
        } else if (state is AdminUpsertParkingAreaFailure) {
          showToast(msg: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AppBackground(
            shoTrailingIcon: true,
            showAppBarIcons: true,
            physics: const BouncingScrollPhysics(),
            customWidget: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.parkingAreaModel == null
                        ? AppStrings.addParkingArea
                        : AppStrings.updateParkingArea,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 20),
                  ),
                  responsive.sizedBoxH30,
                  BuildTextForm(
                    title: AppStrings.areaName,
                    controller: _areaNameController,
                    hintText: "Enter parking area name",
                    error: "Area name can't be empty",
                  ),
                  responsive.sizedBoxH20,
                  BuildTextForm(
                    title: AppStrings.areaNumber,
                    controller: _areaNumberController,
                    hintText: "Enter parking area number",
                    error: "Area number can't be empty",
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Area number can't be empty";
                      }
                      if (int.tryParse(val) == null) {
                        return "Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  responsive.sizedBoxH20,
                  BuildTextForm(
                    title: AppStrings.areaLocation,
                    controller: _areaLocationController,
                    hintText: "Enter parking area location",
                    error: "Area location can't be empty",
                  ),
                  const SizedBox(height: 80),
                  state is AdminUpsertParkingAreaLoading
                      ? const CenteredCircularProgressIndicator(
                          color: ColorManager.primary,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 12.0,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await AdminCubit.get(context).upsertParkingArea(
                                ParkingAreaModel(
                                  id: widget.parkingAreaModel == null
                                      ? DateTime.now().toIso8601String()
                                      : widget.parkingAreaModel!.id,
                                  name: _areaNameController.text,
                                  number: int.parse(_areaNumberController.text),
                                  location: _areaLocationController.text,
                                ),
                              );
                            }
                          },
                          child: Text(widget.parkingAreaModel == null
                              ? AppStrings.add
                              : AppStrings.update),
                        ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

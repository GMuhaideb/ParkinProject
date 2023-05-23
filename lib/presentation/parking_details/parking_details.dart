import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/parking_model.dart';
import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/strings_maneger.dart';
import '../../resources/value_maneger.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';

class ParkingDetails extends StatefulWidget {
  final ParkingModel parkingModel;

  const ParkingDetails({Key? key, required this.parkingModel})
      : super(key: key);

  @override
  State<ParkingDetails> createState() => _ParkingDetailsState();
}

class _ParkingDetailsState extends State<ParkingDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            if (state is DataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorOccurred) {
              return const Text(AppStrings.errorMsg);
            }
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.parkingModel.name),
                      Text("عدد المركبات:${widget.parkingModel.count}"),
                    ],
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: widget.parkingModel.cars.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: const EdgeInsets.all(12),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: ColorManager.radialGradientCard,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p12),
                                    child: Row(children: [
                                      Container(
                                        height:
                                            responsive.sHeight(context) * .06,
                                        width: responsive.sWidth(context) * .12,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.2),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  ImageAssets.splashLogo),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      responsive.sizedBoxW10,
                                      Text(
                                        widget.parkingModel.cars[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        maxLines: 3,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )));
          }),
    );
  }
}

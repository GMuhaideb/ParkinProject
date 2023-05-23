import 'package:flutter/material.dart';

import '../../resources/color_maneger.dart';
import '../../resources/value_maneger.dart';


class MyElevationBottom extends StatelessWidget {
  const MyElevationBottom({
    super.key,
    required this.onTap,
    required this.label,
  });

  final Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s50,
      width: double.infinity,
      decoration: ShapeDecoration(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          gradient: ColorManager.linearGradientMain),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Colors.transparent,
            shadowColor: ColorManager.blueGray,
            elevation: 0),
        child: Text(label),
      ),
    );
  }
}

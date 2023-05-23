// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:parkin/shared/component/component.dart';

import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/routes_maneger.dart';

class AppBackground extends StatelessWidget {
  final bool showAppBarIcons;
  final bool shoTrailingIcon;
  final VoidCallback? trailingOnPress;
  final ScrollPhysics? physics;
  const AppBackground({
    Key? key,
    this.showAppBarIcons = false,
    this.shoTrailingIcon = false,
    this.trailingOnPress,
    this.physics,
    required this.customWidget,
  }) : super(key: key);
  final Widget customWidget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: responsive.sHeight(context),
      child: ListView(
        physics: physics ?? const NeverScrollableScrollPhysics(),
        children: [
          if (showAppBarIcons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: responsive.sHeight(context) * .15,
                  width: responsive.sWidth(context) * .4,
                  child: Image.asset(ImageAssets.whiteLogo),
                ),
                if (shoTrailingIcon)
                  IconButton(
                    onPressed: () {
                      navigateTo(context, Routes.menu);
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  )
                else
                  Container(),
              ],
            )
          else
            SizedBox(
              height: responsive.sHeight(context) * .15,
              width: responsive.sWidth(context) * .4,
              child: Image.asset(ImageAssets.whiteLogo),
            ),
          Container(
            alignment: Alignment.center,
            height: responsive.sHeight(context),
            decoration: const BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.all(20.0), child: customWidget),
          ),
        ],
      ),
    );
  }
}

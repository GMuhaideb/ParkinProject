import 'package:flutter/material.dart';

Responsive responsive = Responsive();

class Responsive {
  MediaQueryData mediaQuery(BuildContext context) => MediaQuery.of(context);

  double textScale(BuildContext context) =>
      MediaQuery.textScaleFactorOf(context);

  double sHeight(BuildContext context) => mediaQuery(context).size.height;

  double sWidth(BuildContext context) => mediaQuery(context).size.width;

  final SizedBox sizedBoxH5 = const SizedBox(
    height: 5,
  );
  final SizedBox sizedBoxH8 = const SizedBox(
    height: 8,
  );
  final SizedBox sizedBoxH10 = const SizedBox(
    height: 10,
  );
  final SizedBox sizedBoxH15 = const SizedBox(
    height: 15,
  );
  final SizedBox sizedBoxH17 = const SizedBox(
    height: 17,
  );
  final SizedBox sizedBoxH20 = const SizedBox(
    height: 20,
  );
  final SizedBox sizedBoxH30 = const SizedBox(
    height: 30,
  );
  final SizedBox sizedBoxH40 = const SizedBox(
    height: 40,
  );
  final SizedBox sizedBoxH50 = const SizedBox(
    height: 50,
  );
  final SizedBox sizedBoxH100 = const SizedBox(
    height: 100,
  );
  final SizedBox sizedBoxW5 = const SizedBox(
    width: 5,
  );
  final SizedBox sizedBoxW10 = const SizedBox(
    width: 10,
  );

  final SizedBox sizedBoxW15 = const SizedBox(
    width: 15,
  );
  final SizedBox sizedBoxW25 = const SizedBox(
    width: 25,
  );
  final SizedBox sizedBoxW50 = const SizedBox(
    width: 50,
  );
  final SizedBox sizedBoxW80 = const SizedBox(
    width: 80,
  );
  final SizedBox sizedBoxW100 = const SizedBox(
    width: 100,
  );

  final Expanded expandedSizedBox = const Expanded(child: SizedBox());
  final Expanded expandedSizedBox2 = const Expanded(flex: 2, child: SizedBox());
  final Expanded expandedSizedBox3 = const Expanded(flex: 3, child: SizedBox());
  final Expanded expandedSizedBox5 = const Expanded(flex: 5, child: SizedBox());
  final EdgeInsets paddingHoriz20 = const EdgeInsets.symmetric(horizontal: 20);
  final EdgeInsets paddingHoriz10 = const EdgeInsets.symmetric(horizontal: 10);
  final EdgeInsets paddingVertical12 = const EdgeInsets.symmetric(vertical: 12);
  final EdgeInsets paddingVertical15 = const EdgeInsets.symmetric(vertical: 15);
  final EdgeInsets paddingHorizontal18Vertical24 =
      const EdgeInsets.symmetric(horizontal: 18, vertical: 24);

  bool isPortrait(BuildContext context) =>
      (sHeight(context) > sWidth(context) ||
          mediaQuery(context).orientation == Orientation.portrait);

  double responsiveHigh(BuildContext context, double ratio) {
    return isPortrait(context)
        ? sHeight(context) * ratio
        : sWidth(context) * ratio;
  }

  double responsiveWidth(BuildContext context, double ratio) {
    return isPortrait(context)
        ? sWidth(context) * ratio
        : sHeight(context) * ratio;
  }

  double appbarTopHigh(AppBar appBar, BuildContext context) =>
      appBar.preferredSize.height + mediaQuery(context).padding.top;

  double screenPadding(BuildContext context) =>
      mediaQuery(context).padding.top + mediaQuery(context).padding.bottom;

  double stepperAppBarH(BuildContext context) => sHeight(context) * .08;

  EdgeInsets listViewPadding =
      const EdgeInsets.symmetric(vertical: 10, horizontal: 15);
}

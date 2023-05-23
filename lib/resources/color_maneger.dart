import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xff2D3D5F);
  static const Color splash = Color(0xff021F4A);
  static const Color silver = Color(0xffCBCBCB);
  static const Color black = Colors.black;
  static const Color yellow = Colors.yellow;
  static const Color darkGrey = Color(0xff525252);
  static const Color grey = Color(0xff737477);
  static const Color lightBlack = Color(0xff3F434A);
  static const Color blueGray = Color(0xff3c5767);
  static const Color blue = Color(0xff5FB8CC);
  static const Color darkBlue = Color(0xff2D3D5F);

  static const Color textForm = Color(0xffE1DFDF);
  static const Color card = Color(0xffEFEFEF);
  static const Color scaffold = Color(0xffEFEFEF);

  static Color story = const Color(0xff1C96A7).withOpacity(.6);
  static LinearGradient linearGradientMain = const LinearGradient(colors: [
    Color(0xff7F339F),
    Color(0xff1C96A7),
  ]);
  static RadialGradient radialGradientCard =
      const RadialGradient(radius: 2, colors: [
    Color(0xffFFFFFF),
    Color(0xffF4F4F4),
    Color(0xffEFEFEF),
  ]);
  static LinearGradient linearGradientMsg = const LinearGradient(colors: [
    Color(0xff27B43D),
    Color(0xff06D81E),
  ]);

  // new colors
  static const Color darkPrimary = Color(0xff116d7a);
  static const Color lightPrimary = Color(0x80021f4a); // color with 80% opacity
  static const Color grey1 = Color(0xff707070);
  static const Color grey2 = Color(0xff797979);
  static const Color formFieldBorder = Color(0xffCECECE);
  static const Color white = Color(0xffFFFFFF);
  static const Color error = Color(0xffe61f34); // red color
}

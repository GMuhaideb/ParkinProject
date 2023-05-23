import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkin/resources/styles_maneger.dart';
import 'package:parkin/resources/value_maneger.dart';

import 'color_maneger.dart';
import 'font_maneger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      scaffoldBackgroundColor: ColorManager.primary,
      // main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary.withOpacity(.5),
      // ripple effect color

      // card view theme
      cardTheme: const CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      // app bar theme
      appBarTheme: AppBarTheme(
          backgroundColor: ColorManager.primary,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorManager.primary,
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: AppSize.s0,
          shadowColor: ColorManager.lightPrimary,
          titleTextStyle: getRegularStyle(
              fontSize: FontSize.s22, color: ColorManager.white)),

      // button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.lightPrimary.withOpacity(.5)),

      // elevated button them
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s17),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
        ),
      ),
      // Text button them
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        textStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s17),
        foregroundColor: ColorManager.primary,
      )),
      // text theme
      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: ColorManager.white, fontSize: FontSize.s30),
          headlineLarge: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s28,
          ),
          headlineMedium: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s25),
          headlineSmall:
              getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s22),
          titleLarge:
              getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20),
          titleMedium:
              getMediumStyle(color: ColorManager.black, fontSize: FontSize.s18),
          titleSmall: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s15),
          bodyLarge: getRegularStyle(
              color: ColorManager.primary, fontSize: FontSize.s18),
          bodySmall: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s12)),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
          // content padding
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          // hint style
          hintStyle: getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s14),
          labelStyle:
              getMediumStyle(color: ColorManager.black, fontSize: FontSize.s14),
          prefixStyle: getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s14),
          prefixIconColor: ColorManager.darkGrey,
          errorStyle: getRegularStyle(color: ColorManager.error),

          // enabled border style
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.formFieldBorder, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s16))),

          // focused border style
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s16))),

          // error border style
          errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s16))),
          // focused border style
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.formFieldBorder, width: AppSize.s1),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)))),

      //bottom nav
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: ColorManager.white,
        unselectedItemColor: ColorManager.white.withOpacity(.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: ColorManager.primary,
      ),
      iconTheme: const IconThemeData(
        color: ColorManager.primary,
      ),
      listTileTheme: const ListTileThemeData(iconColor: ColorManager.primary));
}

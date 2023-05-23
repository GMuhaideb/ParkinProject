import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> navigateTo(context, route, {dynamic arguments}) =>
    Navigator.pushNamed(context, route, arguments: arguments);

void navigateToAndReplacement(context, route) => Navigator.pushReplacementNamed(
      context,
      route,
    );

Widget myDivider() => const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

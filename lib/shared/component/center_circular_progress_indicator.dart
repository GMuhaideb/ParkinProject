import 'package:flutter/material.dart';

class CenteredCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  const CenteredCircularProgressIndicator(
      {super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}

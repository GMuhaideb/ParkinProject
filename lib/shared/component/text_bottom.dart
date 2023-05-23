import 'package:flutter/material.dart';

class MyTextBottom extends StatelessWidget {
  const MyTextBottom({
    super.key,
    required this.onTap,
    this.label,
    // this.child
  });

  final Function() onTap;
  final String? label;
  // final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.bodyLarge)),
      onPressed: onTap,
      child: Text(label ?? ''),
    );
  }
}

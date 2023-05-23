// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:parkin/resources/responsive.dart';

class BuildTextForm extends StatelessWidget {
  final String title;
  final String hintText;
  final String? error;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const BuildTextForm({
    Key? key,
    required this.title,
    required this.hintText,
    this.error,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
          ),
        ),
        responsive.sizedBoxH15,
        TextFormField(
          controller: controller,
          validator: validator ??
              (val) {
                if (val!.isEmpty) {
                  return error;
                }
                return null;
              },
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}

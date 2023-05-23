import 'dart:typed_data';

import 'package:flutter/material.dart';

class AppRoundImage extends StatelessWidget {
  const AppRoundImage(this.provider,
      {Key? key, required this.height, required this.width})
      : super(key: key);

  final ImageProvider provider;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Image(
        image: provider,
        height: height,
        width: width,
      ),
    );
  }

  factory AppRoundImage.url(String url,
      {required double height, required double width}) {
    return AppRoundImage(
      NetworkImage(url),
      width: width,
      height: height,
    );
  }

  factory AppRoundImage.memory(Uint8List data,
      {required double height, required double width}) {
    return AppRoundImage(
      MemoryImage(data),
      width: width,
      height: height,
    );
  }
}

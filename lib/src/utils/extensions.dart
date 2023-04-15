import 'package:flutter/material.dart';

extension strEtx on String {
  Widget iconImage({double? size, Color? color, BoxFit? fit}) {
    return Image.asset(
      this,
      height: size ?? 24,
      width: size ?? 24,
      fit: fit ?? BoxFit.cover,
      color: Colors.white,
      // errorBuilder: (context, error, stackTrace) {
      //   return Image.asset(ic_no_photo, height: size ?? 24, width: size ?? 24);
      // },
    );
  }
}

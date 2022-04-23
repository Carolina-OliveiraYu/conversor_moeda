import 'package:flutter/material.dart';

class MediaQueryScreen {
  static double height(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * (height / 100);
  }

  static double width(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * (width / 100);
  }
}

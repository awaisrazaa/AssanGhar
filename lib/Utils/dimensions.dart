import 'package:flutter/material.dart';

class Dimensions {
  static screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}

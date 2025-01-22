import 'package:flutter/material.dart';

class ScreenUtil {
  late BuildContext context;
  late double screenWidth;
  late double screenHeight;

  ScreenUtil(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // Height based on percentage
  double height(double percentage) => screenHeight * (percentage / 100);

  // Width based on percentage
  double width(double percentage) => screenWidth * (percentage / 100);

  // Font size adjustment based on screen width
  double fontSize(double size) => screenWidth * (size / 375);

  // Dynamic padding
  EdgeInsets padding({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) =>
      EdgeInsets.only(
        top: height(top),
        bottom: height(bottom),
        left: width(left),
        right: width(right),
      );

  // Dynamic margin
  EdgeInsets margin({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) =>
      EdgeInsets.only(
        top: height(top),
        bottom: height(bottom),
        left: width(left),
        right: width(right),
      );
}

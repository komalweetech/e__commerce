// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class MyColors {

  static const Color whiteBG = Color(0xffF9FAFB);
  static const Color textFieldBG = Color(0xffFFFFFF);
  static const Color textFieldHint = Color(0xffA8AFB9);
  static const Color primaryColor = Color(0xffDB3022);
  static const Color secondPrimary = Color(0xffF3574A);

  // Gradients
  static const LinearGradient gradientBG = LinearGradient(
    colors: [Color(0xffff9966), Color(0xffff5e62)],
  );

  static const LinearGradient gradient85032Toff9068 = LinearGradient(
    colors: [Color(0xfff85032), Color(0xffff9068)],
  );
  static const LinearGradient gradient4B3EE1To2575FCTopToBottom =
  LinearGradient(
    colors: [Color(0xff4B3EE1), Color(0xff2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradient0014FFTo00E5FF = LinearGradient(
    colors: [Color(0xff0014FF), Color(0xff00E5FF)],
  );
  static const LinearGradient gradient0014FFTo00E5FFTopToBottom =
  LinearGradient(
    // colors: [Color(0xff0014FF), Color(0xff00E5FF)],
    colors: [Color(0xff601FD2), Color(0xff2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradient601FD2x2575FC = LinearGradient(
    colors: [Color(0xff601FD2), Color(0xff2575FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );




}

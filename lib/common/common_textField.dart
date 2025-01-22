import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/my_colors.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIconPath;
  final TextInputType keyboardType;
  final bool obscureText;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIconPath,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.mainColor.withOpacity(0.5)),
          color:  MyColors.textFieldBG, // Example background color
        ),
        child: Center(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: MyColors.textFieldHint,fontSize: 18,fontWeight: FontWeight.w700),
              prefixIcon:Padding(
                padding: const EdgeInsets.all(15), // Adjust padding as needed
                child: Image.asset(
                  prefixIconPath,
                  width: 20,
                  height: 20,
                  color: MyColors.textFieldHint,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../theme/my_colors.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: MyColors.textFieldHint, // Color of the divider
            thickness: 1, // Thickness of the divider
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey, // Color of the text
              fontSize: 16, // Size of the text
              fontWeight: FontWeight.w600, // Weight of the text
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: MyColors.textFieldHint,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

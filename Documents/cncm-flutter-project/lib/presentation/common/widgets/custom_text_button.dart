import 'package:flutter/material.dart';

import '../../../core/colors.dart';

Widget customTextButton(
    {required String text,
    required Function onPressed,
    Color textColor = greyText,
    Color backgroundColor = Colors.transparent,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500}) {
  return  TextButton(
    style: TextButton.styleFrom(
      primary: green,
      backgroundColor: backgroundColor, // Background Color
    ),
    child: SizedBox(
      height: 20,
      width: 70,
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: textColor )),
      ),
    ),
    onPressed: () {
      onPressed();
      // bloc.add(AssetTypeChangedEvent(AssetType.mysql));
    },
  );
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget customButton(
    {required String text,
    required Function onClick,
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor, bool isBold = false
    }) {
  return InkWell(
    onTap: () {
      onClick();
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.green,
        borderRadius: BorderRadius.circular(8),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 2)
            : null,
      ),
      height: 55,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor ?? Colors.white, fontSize: 14,  fontWeight: isBold ? FontWeight.w600 : FontWeight.normal),
          // textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

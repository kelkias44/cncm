import 'package:flutter/material.dart';

import '../../../core/colors.dart';

Widget stepperButton(
    {
      required Function onPressed,
      required IconData icon,
      Color iconColor = Colors.white,
      Color backgroundColor = Colors.white, }) {
  return  FloatingActionButton.small(
    backgroundColor:  backgroundColor,
    elevation: 0,
    onPressed: () {
      onPressed();
    },
    heroTag: null, // if not this will happen:: I/flutter (21786): In this case, multiple heroes had the following tag: default FloatingActionButton tag
    child:Icon(
      icon,
      color: iconColor,
    ),
  );

}
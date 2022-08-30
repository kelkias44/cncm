import 'package:flutter/material.dart';

import '../pages/add_assets_page.dart';

InputDecoration buildInputDecoration({required String hintText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(left: AddAssetPage.kPadding),
    fillColor:  const Color(0XFFf0f0f0),
    focusedBorder: buildUnderlineInputBorder(),
    border:   OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
      //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
    ),
    filled: true,
    hintText: ' $hintText',
  );
}

UnderlineInputBorder buildUnderlineInputBorder() {
  return UnderlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.green, width: 1),
  );
}

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(7),
    color: const Color(0XFFf0f0f0),
  );
}
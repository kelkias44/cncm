import 'package:flutter/material.dart';

import 'decorations.dart';

/// form  field
Widget buildNumberFormField(
    {required String hintText,
      required TextEditingController dataValue,
      required String errorMessage,
      required BuildContext context,
      bool isEnabled = true}) {
  return TextFormField(
    controller: dataValue,
    enabled: isEnabled,
    keyboardType: TextInputType.number,
    // onChanged: (value) => dataValue.text = value.toString(),
    onSaved: (value) => dataValue.text = value!.toString(),
    validator: (val) => val!.isNotEmpty ? null : errorMessage,
    decoration: buildInputDecoration(hintText: hintText),
  );
  //   Container(
  //   width: MediaQuery.of(context).size.width,
  //   height: 50,
  //   decoration: buildBoxDecoration(),
  //   child:
  // );
}
import 'package:flutter/material.dart';

import 'decorations.dart';

/// form  field
Widget buildFormField(
    {required String hintText,
      required TextEditingController dataValue,
      required String errorMessage,
      required BuildContext context,
      bool isEnabled = false,
      Function? onTap,
    }) {
  return TextFormField(
   // initialValue: dataValue.text,
    controller: dataValue,
    readOnly: isEnabled,
    // onChanged: (value) => dataValue.text = value,
    onSaved: (value) => dataValue.text = value!,
    validator: (val) => val!.isNotEmpty ? null : errorMessage,
    decoration: buildInputDecoration(hintText: hintText),
    onTap: (){
      if(onTap != null){
        onTap();
      }

    },
  );
}

Widget buildReadOnlyFormField(
    {required String hintText,
      required String dataValue,
      required BuildContext context,
      bool isReadOnly = true,
      Function? onTap,
    }) {
  return TextFormField(
     initialValue: dataValue,
    readOnly: isReadOnly,
    onChanged: (value) => dataValue = value,
    onSaved: (value) => dataValue = value!,
    decoration: buildInputDecoration(hintText: hintText),
    onTap: (){
       if (onTap != null) {
        onTap();
       }
    },
  );
}

Container buildTextField(
    {bool isEnabled = true,
      Function? onTap,
      required String hintText,
      required TextEditingController controller}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: buildBoxDecoration(),
    child: TextFormField(
      onTap: (){
        if(onTap!=null){
          onTap();
        }
        },
      controller: controller,
      readOnly: !isEnabled,
      decoration: buildInputDecoration(hintText: hintText),
      validator: (v) {
        if (v!.trim().isEmpty) {
          return 'this filed is required';
        }
        return null;
      },
    ),
  );
}

///half text field
Container buildHalfTextField(
    {required String hintText,
      required TextEditingController controller,
      required BuildContext context}) {
  return Container(
    width: MediaQuery.of(context).size.width / 2.5,
    height: 50,
    decoration: buildBoxDecoration(),
    child: TextField(
      controller: controller,
      decoration: buildInputDecoration(hintText: hintText),
    ),
  );
}
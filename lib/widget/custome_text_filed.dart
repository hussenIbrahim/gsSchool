import 'package:flutter/material.dart';

import 'package:testgsschoolst/main.dart';

class CustomeTextFiled extends StatelessWidget {
  final controller;
  final TextInputType textInputType;
  final Function validate;
  final Widget prefixIcon;
  final String hintText;
final maxLines;
  const CustomeTextFiled(
      {Key key,
      this.controller,
      this.textInputType,  this.maxLines=1,
      this.validate,
      this.prefixIcon,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validate,
          decoration: InputDecoration(
            focusedBorder: myTheme.textFormField,
            enabledBorder: myTheme.textFormField,
            border: InputBorder.none,
            hintText: '$hintText',
            prefixIcon: prefixIcon,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testgsschoolst/locator.dart';

import 'responsev.dart';
 
class ComesTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final String hintText;
  final String Function(String) validator;
  final bool readOnly;
  final TextInputType keyBoradType;
  final Function onSubmit;
  final FocusNode focusNode;
  final Function onChange;
  final Widget prefixIcon;
  final Widget subFixIcon;

  const ComesTextFiled({
    Key key,
    @required this.controller,
    this.prefixIcon,
    this.subFixIcon,
    @required this.onSubmit,
    this.onChange,
    @required this.focusNode,
    @required this.inputFormatters,
    @required this.hintText,
    @required this.keyBoradType,
    @required this.validator,
    this.readOnly = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(platform: TargetPlatform.android),
        child: TextFormField(
          style: TextStyle(
            height: 1.0,
            fontSize: Responsive().setSp(
              18,
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChange,
          keyboardType: keyBoradType,
          inputFormatters: inputFormatters,
          textAlignVertical: TextAlignVertical.center,
          onFieldSubmitted: onSubmit,
          readOnly: readOnly,
          decoration: InputDecoration(
            suffixIcon: prefixIcon ??
               null,
            hintStyle: TextStyle(
              fontSize: Responsive().setSp(
                22,
              ),
            ),
            labelStyle: TextStyle(
              fontSize: Responsive().setSp(
                22,
              ),
            ),

            labelText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            // fillColor: Colors.white,
            // filled: true,
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}

class DisAbleComesTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final String hintText;
  final String Function(String) validator;
  final bool isReadMonly;
  final TextInputType keyBoradType;
  final Widget prefixIcon;
  final Function onTap;
  final Widget suffixIcon;
  const DisAbleComesTextFiled({
    Key key,
    @required this.controller,
    @required this.onTap,
    @required this.inputFormatters,
    @required this.hintText,
    @required this.prefixIcon,
    @required this.suffixIcon,
    @required this.keyBoradType,
    @required this.validator,
    this.isReadMonly = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myPrint(controller.text);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(platform: TargetPlatform.android),
        child: TextFormField(
          style: TextStyle(
            height: 1.0,
            fontSize: Responsive().setSp(
              18,
            ),
          ),
          autovalidateMode: AutovalidateMode.always,
          controller: controller,
          keyboardType: keyBoradType,
          inputFormatters: inputFormatters,
          textAlignVertical: TextAlignVertical.center,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
          },
          onTap: onTap,
          readOnly: isReadMonly,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            labelText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            // fillColor: Colors.white,
            // filled: true,
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}

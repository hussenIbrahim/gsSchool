import 'package:flutter/material.dart';

Future<DateTime> selectDate(BuildContext context, DateTime initDate,) async {
  if (initDate == null) {
    initDate = DateTime(1945);
  }
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: initDate,
    // Refer step 1
    firstDate: DateTime(1945),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            onPrimary: Colors.white,
            onSurface: Colors.black54,
          ),
          dialogBackgroundColor: Colors.grey.shade100,
        ),
        child: child,
      );
    },
  );

  return picked;
}

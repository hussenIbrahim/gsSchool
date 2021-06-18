import 'dart:io';

import 'package:flutter/material.dart';

class AttachmentNotifier extends ChangeNotifier {
  File _file;

  File get getFile => _file;

  set setFile(File file) {
    _file = file;
    notifyListeners();
  }

  detToDef() {
    _file = null;
    notifyListeners();
  }

  DateTime _selectedDate;

  DateTime get getBirthDay => _selectedDate;

  set setBirthDay(DateTime selectedDate) {
    _selectedDate = selectedDate;
  }

  changeSelectedDateTime(DateTime newByMain) {
    _selectedDate = newByMain;

    notifyListeners();
  }
}

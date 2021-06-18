import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/student/services/student_model.dart';
import 'package:testgsschoolst/screens/student/services/student_services.dart';

import '../../../locator.dart';

class StudentNotifer extends ChangeNotifier {
  Status getDataStatus = Status.dataFound;
  List<StudentModel> students = [];
  final services = locator<StudentServices>();
  StudentModel student;

  getPicksForYouOffers() async {
    StudentRequest data = await services.getStudents();
    getDataStatus = data.status;
    myPrint("studebts data  $data");

    if (getDataStatus == Status.dataFound) {
      final List<StudentModel> _productModelList = data.data;

      students.addAll(_productModelList);
    }

    final _ids = students.map((e) => e.id).toSet();
    students.retainWhere((x) => _ids.remove(x.id));
    students.sort((a, b) => b.id.compareTo(a.id));

    notifyListeners();
  }

  refresh() {
    getDataStatus = Status.loading;

    students = [];
    student = null;
    notifyListeners();
    getPicksForYouOffers();
  }

  setToDef() {
    getDataStatus = Status.loading;
    students = [];
    student = null;
    notifyListeners();
  }

  changeStudent(String val) {
    student = students.firstWhere((element) => element.id == val);
    notifyListeners();
  }
}

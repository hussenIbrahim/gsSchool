import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/exames/services/exames_mode.dart';
import 'package:testgsschoolst/screens/exames/services/exames_services.dart';

import '../../../locator.dart';

class ExamesNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<ExamesModel> subjects = [];
  final services = locator<ExamesServices>();

  getSubectss(bool forceRefesh) async {
    ExamesModelResponse data = await services.getSubjectSMidleWares(
        isForce: forceRefesh, studentId: getUserId());
    getDataStatus = data.status;
    myPrint("BooksModelResponse data  $data");

    if (getDataStatus == Status.dataFound) {
      subjects.addAll(data.data);
    }

    final _ids = data.data.map((e) => e.id).toSet();
    subjects.retainWhere((x) => _ids.remove(x.id));

    notifyListeners();
  }

  upDateSubjects(ExamesModel model) {
    subjects[subjects.indexWhere((element) => element.id == model.id)] = model;
    notifyListeners();
  }

  Future refresh(bool force) async {
    notifyListeners();
    await getSubectss(force);
  }
}

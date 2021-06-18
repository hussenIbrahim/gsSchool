import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_services.dart';

import '../../../locator.dart';

class SubJectsNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<SubjectModel> subjects = [];
  final services = locator<SubjectsServices>();

  getSubectss(bool forceRefesh) async {
    SubjectModelResponse data = await services.getSubjectSMidleWares(
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
upDateSubjects(SubjectModel model){
  subjects[subjects.indexWhere((element) => element.id==model.id)] = model;
  notifyListeners();
}
  Future refresh(bool force) async {
    notifyListeners();
    await getSubectss(force);
  }
}

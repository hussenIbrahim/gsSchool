import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/online_quizs/services/online_quiz_model.dart';
import 'package:testgsschoolst/screens/online_quizs/services/online_quiz_services.dart';

import '../../../locator.dart';

class OnlineQuizNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<OnLineQuizModel> subjects = [];
  final services = locator<OnlineQuizServices>();

  getSubectss(bool forceRefesh) async {
    OnLineQuizModelResponse data = await services.getExamesMidleWares(
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

  

  Future refresh(bool force) async {
     await getSubectss(force);
  }
}

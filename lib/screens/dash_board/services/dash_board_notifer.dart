import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/dash_board/services/dash_board_services.dart';
import 'package:testgsschoolst/screens/dash_board/services/models.dart';
import 'package:testgsschoolst/screens/exames/services/exames_mode.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_model.dart';

import '../../../locator.dart';

class DashBoardNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<ScheduleModel> offersList = [];
  List<HomeWorksModel> homeworks = [];
  List<ExamesModel> exams = [];
  final services = locator<DashBoardServices>();

  getBooks(bool forceRefesh) async {
    ScheduleTodayModelResponse data =
        await services.getOffers(forceRefesh, getUserId());
    getDataStatus = data.status;
    myPrint("BooksModelResponse data  $data");

    if (getDataStatus == Status.dataFound) {
      offersList = data.schedules;
      homeworks = data.homeworks;
      exams = data.exames;
    } else if (offersList.length > 0 ||
        homeworks.length > 0 ||
        exams.length > 0) {
      getDataStatus = Status.dataFound;
    }

    getDataStatus = Status.dataFound;
    myPrint("getDataStatus $getDataStatus");
    notifyListeners();
  }

  Future refresh(bool force) async {
    await getBooks(force);
  }
}

import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_model.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_services.dart';

import '../../../locator.dart';

class ScheduleNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<ScheduleModel> eventsList = [];
  final services = locator<ScheduleServices>();

  String day = "all";

  changeSubjectModel(String newYear) {
    day = newYear;

    notifyListeners();
    refresh(false);
  }

  getPicksForYouOffers(bool forceReresh) async {
    ScheduleModellResponse data =
        await services.getSchudleMiddleWare(day, forceReresh);
    getDataStatus = data.status;
    myPrint("ScheduleModelResponse data  $data");

    if (getDataStatus == Status.dataFound) {
      final List<ScheduleModel> _productModelList = data.data;

      eventsList.addAll(_productModelList);
    }

    final _ids = eventsList.map((e) {
      myPrint(e?.toString());
      return e.id;
    }).toSet();
    eventsList.retainWhere((x) => _ids.remove(x.id));
    eventsList.sort((a, b) => b.id.compareTo(a.id));
    eventsList = eventsList.where((element) {
      return day == "all" || element.dayName == day;
    }).toList();
    if (eventsList.length == 0) {
      getDataStatus = Status.noDataFound;
    }

    notifyListeners();
  }

  refresh(bool forceRefresh) {
    getDataStatus = Status.loading;
    eventsList = [];
    eventsList = [];
    notifyListeners();
    getPicksForYouOffers(forceRefresh);
  }

  setDataToDefalut() {
    getDataStatus = Status.initState;
    eventsList = [];
    notifyListeners();
  }
}

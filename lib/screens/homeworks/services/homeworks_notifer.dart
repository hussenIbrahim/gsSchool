import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_services.dart';

import '../../../locator.dart';

class HomeWorkNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<HomeWorksModel> eventsList = [];
  final services = locator<HomeWorksModelServices>();
  String subjectModel;

  changeYear(int deffDays, String _subjectModel) {
    DateTime.now().add(Duration(days: deffDays));
    subjectModel = _subjectModel;
    notifyListeners();
  }

  getPicksForYouOffers(bool foreceUpdate) async {
    HomeWorksModellResponse data =
        await services.getHomeWorksMiddleWare(foreceUpdate, "");
    getDataStatus = data.status;
    myPrint("HomeWorksModelResponse data  $data");

    if (getDataStatus == Status.dataFound) {
      final List<HomeWorksModel> _productModelList = data.data;

      eventsList.addAll(_productModelList);
    } else {
      if (getDataStatus == Status.noDataFound && eventsList.length > 0) {
        getDataStatus = Status.dataFound;
      } else if (eventsList.length > 0) {
        getDataStatus = Status.dataFound;
      }
    }

    final _ids = eventsList.map((e) => e.id).toSet();
    eventsList.retainWhere((x) => _ids.remove(x.id));

    notifyListeners();
  }

  refresh(bool foreceUpdate) {
    getDataStatus = Status.loading;

    eventsList = [];

    notifyListeners();
    getPicksForYouOffers(foreceUpdate);
  }

  setDashBoardState(Status newDashBoardStatus) {
    getDataStatus = newDashBoardStatus;
    eventsList = [];

    notifyListeners();
  }

  setDataToDefalut() {
    getDataStatus = Status.initState;
    eventsList = [];

    notifyListeners();
  }
}

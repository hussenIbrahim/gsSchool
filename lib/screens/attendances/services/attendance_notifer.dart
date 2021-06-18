import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_model.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_services.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';

import '../../../locator.dart';

class AttendanceNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<AttendanceModel> eventsList = [];
  final services = locator<AttendanceServices>();
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  changeYear(int newYear) {
    selectedYear = newYear;
    notifyListeners();
  }

  changeMonth(int newYear) {
    selectedMonth = newYear;
    notifyListeners();
  }

  SubjectModel subjectModel;
  List<SubjectModel> subjects = [];
  setSubjects(List<SubjectModel> _subjects) {
    subjects = _subjects;
    notifyListeners();
  }

  changeSubjectModel(SubjectModel newYear) {
    subjectModel = newYear;

    notifyListeners();
    refresh();
  }

  int page = 0;
  PaginationStatus paginations = PaginationStatus.notMatch;
  changePaginationStatus(PaginationStatus newValue) {
    paginations = newValue;
    notifyListeners();
  }

  List<int> ids = [];
  getPicksForYouOffers() async {
    AttendanceModelResponse data =
        await services.getChatPersons(page);
    getDataStatus = data.status;
    myPrint("AttendanceModelResponse data  $data");

    if (getDataStatus == Status.dataFound) {
      page = page + 1;
      final List<AttendanceModel> _productModelList = data.data;

      eventsList.addAll(_productModelList);
      if (_productModelList.length < 15) {
        paginations = PaginationStatus.matchToEnd;
      } else {
        paginations = PaginationStatus.notMatch;
      }
    } else {
      if (getDataStatus == Status.noDataFound) {
        paginations = PaginationStatus.matchToEnd;
      } else {
        paginations = PaginationStatus.notMatch;
      }
      if (getDataStatus == Status.noDataFound && eventsList.length > 0) {
        getDataStatus = Status.dataFound;
      } else if (page > 0) {
        showToast(Translate.cannotloadmore.trans());
        getDataStatus = Status.dataFound;
      } else if (eventsList.length > 0) {
        getDataStatus = Status.dataFound;
      }
    }

    final _ids = eventsList.map((e) {
      myPrint(e?.toString());
      return e.id;
    }).toSet();
    eventsList.retainWhere((x) => _ids.remove(x.id));
    eventsList.sort((a, b) => b.id.compareTo(a.id));

    notifyListeners();
  }

  refresh() {
    getDataStatus = Status.loading;

    page = 0;
    eventsList = [];
    eventsList = [];
    paginations = PaginationStatus.notMatch;
    notifyListeners();
    getPicksForYouOffers();
  }

  setDashBoardState(Status newDashBoardStatus) {
    getDataStatus = newDashBoardStatus;
    page = 0;
    paginations = PaginationStatus.notMatch;
    eventsList = [];

    notifyListeners();
  }

  setIDS(List<int> newIDS) {
    ids = newIDS;
  }

  changePrice() {
    notifyListeners();
  }

  setDataToDefalut() {
    getDataStatus = Status.initState;
    eventsList = [];
    notifyListeners();
  }
}

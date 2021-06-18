import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/chat_screen/services/chat_services.dart';
import 'package:testgsschoolst/screens/chat_screen/services/person_model.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';

import '../../../locator.dart';

class ChatNotifer extends ChangeNotifier {
  Status getDataStatus = Status.dataFound;
  List<Messages> offersList = [];
  final services = locator<ChatServices>();
  List<Messages> _offersList = [];

  int page = 0;
  String searchQuery = "";
  PaginationStatus paginations = PaginationStatus.notMatch;
  changePaginationStatus(PaginationStatus newValue) {
    paginations = newValue;
    notifyListeners();
  }

  setFromHive(List<Messages> list) {
    offersList = list;
    getDataStatus = Status.dataFound;
    notifyListeners();
  }

  List<int> ids = [];
  getPicksForYouOffers() async {
    ChatPersonsModelResponse data = await services.getSelectedPersonMessages(
      page,
      searchQuery,
    );
    getDataStatus = data.status;
    myPrint("getSuppliers data  $data");

    if (getDataStatus == Status.dataFound) {
      page = page + 1;
      final List<Messages> _productModelList = data.data;

      _offersList.addAll(_productModelList);
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
      if (getDataStatus == Status.noDataFound && _offersList.length > 0) {
        getDataStatus = Status.dataFound;
      } else if (page > 0) {
        showToast(Translate.cannotloadmore.trans());
        getDataStatus = Status.dataFound;
      } else if (offersList.length > 0) {
        getDataStatus = Status.dataFound;
      }
    }

    final _ids = _offersList.map((e) {
      myPrint(e?.toString());
      return e.id;
    }).toSet();
    _offersList.retainWhere((x) => _ids.remove(x.id));
    _offersList.sort((a, b) => b.id.compareTo(a.id));
    if (offersList.length == 0) {
      offersList = _offersList;
      notifyListeners();
    }
  }

  refresh() {
    getDataStatus = Status.loading;

    page = 0;
    offersList = [];
    _offersList = [];
    paginations = PaginationStatus.notMatch;
    notifyListeners();
    getPicksForYouOffers();
  }

  setDashBoardState(Status newDashBoardStatus) {
    getDataStatus = newDashBoardStatus;
    page = 0;
    paginations = PaginationStatus.notMatch;
    offersList = [];
    _offersList = [];

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
    offersList = [];
    notifyListeners();
  }
}

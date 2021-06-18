import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/chat_screen/services/chat_services.dart';
import 'package:testgsschoolst/screens/chat_screen/services/person_model.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';

import '../../../locator.dart';

class MessagesNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<Messages> messagesList = [];
  final services = locator<ChatServices>();
  List<Messages> _offersList = [];

  int page = 0;
  String searchQuery = "";
  PaginationStatus paginations = PaginationStatus.notMatch;
  changePaginationStatus(PaginationStatus newValue) {
    paginations = newValue;
    notifyListeners();
  }

 
 
  getPicksForYouOffers(String forUser) async {
    messagesList = [];
    for (var item in _offersList) {
      if (item.forUser == forUser) {
        messagesList.add(item);
      }
    }
    if (messagesList.length > 0) {
      getDataStatus = Status.dataFound;
      page = messagesList.length ~/ limit;
      notifyListeners();
      return;
    }

    ChatPersonsModelResponse data =
        await services.getChatPersons(page, searchQuery);
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
      } else if (messagesList.length > 0) {
        getDataStatus = Status.dataFound;
      }
    }

    final _ids = _offersList.map((e) {
      myPrint(e?.toString());
      return e.id;
    }).toSet();
    _offersList.retainWhere((x) => _ids.remove(x.id));
    _offersList.sort((a, b) => b.id.compareTo(a.id));
    if (messagesList.length == 0) {
      messagesList = _offersList;
      notifyListeners();
    }
  }

  refresh(String forUserid) {
    getDataStatus = Status.loading;

    page = 0;
    messagesList = [];
    _offersList = [];
    paginations = PaginationStatus.notMatch;
    notifyListeners();
    getPicksForYouOffers(forUserid);
  }

  setDashBoardState(Status newDashBoardStatus) {
    getDataStatus = newDashBoardStatus;
    page = 0;
    paginations = PaginationStatus.notMatch;
    messagesList = [];
    _offersList = [];

    notifyListeners();
  }

  
  setDataToDefalut() {
    getDataStatus = Status.initState;
    messagesList = [];
    notifyListeners();
  }
}

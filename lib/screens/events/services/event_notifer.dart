import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/events/services/event_model.dart';
import 'package:testgsschoolst/screens/events/services/event_services.dart';

import '../../../locator.dart';

class EventsNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<EventModel> eventsList = [];
  final services = locator<EventsServices>();
 

  getPicksForYouOffers(bool forceGet) async {
    EventModelResponse data = await services.getEventMiddleWare( forceGet);
    getDataStatus = data.status;
    myPrint("EventModelResponse data  $data");

    if (getDataStatus == Status.dataFound) {
      
      final List<EventModel> _productModelList = data.data;

      eventsList.addAll(_productModelList);
       
    } else {
      
      if (getDataStatus == Status.noDataFound && eventsList.length > 0) {
        getDataStatus = Status.dataFound;
      }  else if (eventsList.length > 0) {
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

  Future refresh(bool forceGet) async {
   
     await getPicksForYouOffers(forceGet);
  }

  setDataToDefalut() {
    getDataStatus = Status.initState;
    eventsList = [];
 
    notifyListeners();
  }
}

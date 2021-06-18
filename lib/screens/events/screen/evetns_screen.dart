import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/events/screen/events_widget.dart';
import 'package:testgsschoolst/screens/events/services/event_notifer.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({Key key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<EventsScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      eventsNotifer = Provider.of<EventsNotifer>(context, listen: false);
      if (eventsNotifer.getDataStatus != Status.loading &&
          eventsNotifer.eventsList.length == 0) {
        eventsNotifer.getPicksForYouOffers(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await eventsNotifer.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<EventsNotifer>(builder: (context, myType, child) {
              if (myType.getDataStatus == Status.loading ||
                  myType.getDataStatus == Status.initState) {
                return ProgressWidget();
              } else if (myType.getDataStatus == Status.error) {
                return FaliedLoadPageWIdget(
                    onPress: refresh, text: "Failed load Evetns");
              } else if (myType.getDataStatus == Status.newtworkError) {
                return NetWorkErrorWidget(
                    onPress: refresh, text: "Failed load Evetns");
              } else if (myType.getDataStatus == Status.noDataFound) {
                return NoDataFound(onPress: refresh, text: "No Evetns Found");
              } else if (myType.getDataStatus == Status.dataFound) {
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.separated(
                              itemCount: myType.eventsList.length,
                              itemBuilder:
                                  (BuildContext context, int index) =>
                                      EventsWidget(
                                model: myType.eventsList[index],
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            ))),
                   
                  ],
                );
              } else {
                return ProgressWidget();
              }
            }),
          ),
        ],
      ),
    );
  }
}

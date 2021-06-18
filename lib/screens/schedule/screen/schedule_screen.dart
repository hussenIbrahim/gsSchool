import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/schedule/screen/schedule_widget.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_notifer.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      scheduleNotifer = Provider.of<ScheduleNotifer>(context, listen: false);
      if (scheduleNotifer.getDataStatus != Status.loading &&
          scheduleNotifer.eventsList.length == 0) {
        scheduleNotifer.getPicksForYouOffers(true);
      }
      if (subJectsNotifer.getDataStatus != Status.loading &&
          subJectsNotifer.subjects.length == 0) {
        subJectsNotifer.getSubectss(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await scheduleNotifer.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    List<String> month = [
      Translate.all,
      Translate.saturday,
      Translate.sunday,
      Translate.monday,
      Translate.tuesday,
      Translate.wednesday,
      Translate.thursday,
      Translate.friday,
    ];

    return Scaffold(
      body: Column(
        children: [
          Consumer<ScheduleNotifer>(builder: (context, myType, child) {
            return Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: DropdownButtonFormField<String>(
                      items: month.map((String category) {
                        return new DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: <Widget>[
                                Text("$category"),
                              ],
                            ));
                      }).toList(),
                      onChanged: (String newValue) {
                        // do other stuff with _category
                        myType.changeSubjectModel(newValue);
                      },
                      value: myType.day,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.grey[200],
                        hintText: "Select Subject",
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Consumer<ScheduleNotifer>(builder: (context, myType, child) {
              if (myType.getDataStatus == Status.loading ||
                  myType.getDataStatus == Status.initState) {
                return ProgressWidget();
              } else if (myType.getDataStatus == Status.error) {
                return FaliedLoadPageWIdget(
                    onPress: refresh, text: "Failed load Schedule");
              } else if (myType.getDataStatus == Status.newtworkError) {
                return NetWorkErrorWidget(
                    onPress: refresh, text: "Failed load Schedule");
              } else if (myType.getDataStatus == Status.noDataFound) {
                return NoDataFound(onPress: refresh, text: "No Schedule Found");
              } else if (myType.getDataStatus == Status.dataFound) {
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.separated(
                              itemCount: myType.eventsList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ScheduleWidget(
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

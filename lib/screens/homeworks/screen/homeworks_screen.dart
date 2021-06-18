import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/homeworks/screen/homeworks_widget.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_notifer.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class HomeWorkScreen extends StatefulWidget {
  HomeWorkScreen({Key key}) : super(key: key);

  @override
  _HomeWorkScreenState createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      homeWorkNotifer = Provider.of<HomeWorkNotifer>(context, listen: false);
      if (homeWorkNotifer.getDataStatus != Status.loading &&
          homeWorkNotifer.eventsList.length == 0) {
        homeWorkNotifer.getPicksForYouOffers(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await homeWorkNotifer.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    List<String> month = [
      Translate.today,
      Translate.tomorrow,
      "Next 7 Days",
      "Last 7 Days",
      Translate.yesterday,
    ];

    return Scaffold(
      body: Column(
        children: [
          Consumer<HomeWorkNotifer>(builder: (context, myType, child) {
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
                        int deff = 1;
                        if (newValue == Translate.today) {
                          deff = 0;
                        } else if (newValue == Translate.tomorrow) {
                          deff = 1;
                        } else if (newValue == "Next 7 Days") {
                          deff = 7;
                        } else if (newValue == "Last 7 Days") {
                          deff = -7;
                        } else if (newValue == Translate.yesterday) {
                          deff = -1;
                        }

                        myType.changeYear(deff, newValue);
                      },
                      value: myType.subjectModel,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.grey[200],
                        hintText: "Select Day",
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Consumer<HomeWorkNotifer>(builder: (context, myType, child) {
              if (myType.getDataStatus == Status.loading ||
                  myType.getDataStatus == Status.initState) {
                return ProgressWidget();
              } else if (myType.getDataStatus == Status.error) {
                return FaliedLoadPageWIdget(
                    onPress: refresh, text: "Failed load HomeWork");
              } else if (myType.getDataStatus == Status.newtworkError) {
                return NetWorkErrorWidget(
                    onPress: refresh, text: "Failed load HomeWork");
              } else if (myType.getDataStatus == Status.noDataFound) {
                return NoDataFound(onPress: refresh, text: "No HomeWork Found");
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
                                      HomeWorkWidget(
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

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/attendances/screen/attendance_widget.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_notifer.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({Key key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<AttendanceScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      attendanceNotifer =
          Provider.of<AttendanceNotifer>(context, listen: false);
      if (attendanceNotifer.getDataStatus != Status.loading &&
          attendanceNotifer.eventsList.length == 0) {
        attendanceNotifer.getPicksForYouOffers();
      }
      if (subJectsNotifer.getDataStatus != Status.loading &&
          subJectsNotifer.subjects.length == 0) {
        subJectsNotifer.getSubectss(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await attendanceNotifer.refresh();
  }

  @override
  Widget build(BuildContext context) {
    // ENGLISH.forEach((key, value) {
    //   log("'$key':{'en':'$value','ar':'${ARABIC[key]}','pa':'${FARSI[key]}','ku':'${KURDISH[key]}','tr':'${TURKISH[key]}'}");
    // });

    List<int> year = [];
    List<int> month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    for (var i = 2021; i < DateTime.now().year + 1; i++) {
      year.add(i);
    }
    return Scaffold(
      body: Column(
        children: [
          Consumer<AttendanceNotifer>(builder: (context, myType, child) {
            return Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: DropdownButtonFormField<int>(
                          items: year.map((int category) {
                            return new DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    Text("$category"),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (int newValue) {
                            // do other stuff with _category
                            myType.changeYear(newValue);
                          },
                          value: myType.selectedYear,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.grey[200],
                            hintText: "Select Year",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: DropdownButtonFormField<int>(
                          items: month.map((int category) {
                            return new DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    Text("$category"),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (int newValue) {
                            // do other stuff with _category
                            myType.changeMonth(newValue);
                          },
                          value: myType.selectedMonth,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.grey[200],
                            hintText: "Select Month",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: DropdownButtonFormField<SubjectModel>(
                      items: myType.subjects.map((SubjectModel category) {
                        return new DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: <Widget>[
                                Text("${category.name}"),
                              ],
                            ));
                      }).toList(),
                      onChanged: (SubjectModel newValue) {
                        // do other stuff with _category
                        myType.changeSubjectModel(newValue);
                      },
                      value: myType.subjectModel,
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
            child:
                Consumer<AttendanceNotifer>(builder: (context, myType, child) {
              if (myType.getDataStatus == Status.loading ||
                  myType.getDataStatus == Status.initState) {
                return ProgressWidget();
              } else if (myType.getDataStatus == Status.error) {
                return FaliedLoadPageWIdget(
                    onPress: refresh, text: "Failed load Behaves");
              } else if (myType.getDataStatus == Status.newtworkError) {
                return NetWorkErrorWidget(
                    onPress: refresh, text: "Failed load Behaves");
              } else if (myType.getDataStatus == Status.noDataFound) {
                return NoDataFound(onPress: refresh, text: "No Behaves Found");
              } else if (myType.getDataStatus == Status.dataFound) {
                return Column(
                  children: [
                    Expanded(
                        child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (myType.paginations !=
                                      PaginationStatus.loading &&
                                  myType.paginations !=
                                      PaginationStatus.matchToEnd &&
                                  myType.getDataStatus != Status.loading &&
                                  myType.getDataStatus != Status.initState &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                myType.changePaginationStatus(
                                    PaginationStatus.loading);

                                myType.getPicksForYouOffers();
                              }

                              return true;
                            },
                            child: RefreshIndicator(
                                onRefresh: refresh,
                                child: ListView.separated(
                                  itemCount: myType.eventsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          AttendanceWidget(
                                    model: myType.eventsList[index],
                                  ),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider();
                                  },
                                )))),
                    myType.paginations == PaginationStatus.loading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : Container()
                  ],
                );
              } else {
                return ProgressWidget();
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar:
          Consumer<AttendanceNotifer>(builder: (context, myType, child) {
        if (myType.getDataStatus == Status.dataFound) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 5,
                runSpacing: 5,
                children: [
                  Text("Late (2),"),
                  Text("Late With Excuse (2),"),
                  Text("Absent (2),"),
                  Text("Abesnt With Permission (2),"),
                  Text("Holiday (2),"),
                  Text("Half Day (2),"),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          height: 75,
        );
      }),
    );
  }
}

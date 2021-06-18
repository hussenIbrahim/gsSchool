import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/dash_board/screen/exames.dart';
import 'package:testgsschoolst/screens/dash_board/screen/home_works.dart';
import 'package:testgsschoolst/screens/dash_board/screen/sechduling.dart';
import 'package:testgsschoolst/screens/dash_board/services/dash_board_notifer.dart';
import 'package:testgsschoolst/screens/exames/services/exames_mode.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_model.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      dashBoardNotifer = Provider.of<DashBoardNotifer>(context, listen: false);
      if ((dashBoardNotifer.getDataStatus != Status.loading &&
          dashBoardNotifer.offersList.length == 0)) {
        dashBoardNotifer.getBooks(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await dashBoardNotifer.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child:
                Consumer<DashBoardNotifer>(builder: (context, myType, child) {
              if (myType.getDataStatus == Status.loading ||
                  myType.getDataStatus == Status.initState) {
                return ProgressWidget();
              } else if (myType.getDataStatus == Status.error) {
                return FaliedLoadPageWIdget(
                    onPress: refresh, text: "Failed load Dash board");
              } else if (myType.getDataStatus == Status.newtworkError) {
                return NetWorkErrorWidget(
                    onPress: refresh, text: "Failed load Dash board");
              } else if (myType.getDataStatus == Status.noDataFound) {
                return NoDataFound(
                    onPress: refresh, text: "No Dash board Found");
              } else if (myType.getDataStatus == Status.dataFound) {
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView(
                              children: [
                                TodaySchdulingScreen(list: [
                                  ScheduleModel(
                                    dayName: "Sat",
                                    durationInMinutes: 50,
                                    subjectName: "Math",
                                    lessonNo: 2,
                                  )
                                ]),
                                //  / TodaySchdulingScreen(list: myType.offersList),

                                Divider(
                                  thickness: 5,
                                  color: Colors.amberAccent,
                                  endIndent: 5,
                                  indent: 5,
                                ),
                                // DashBoardExames(list: myType.exams),
                                DashBoardExames(list:[ExamesModel(examTitle: "Math Exam" , fullMarks: 20 ,dateOfExam: DateTime.now())]),
                                Divider(
                                  thickness: 5,
                                  color: Colors.amberAccent,
                                  endIndent: 5,
                                  indent: 5,
                                ),
                                DashBoardHomeWork(list:[HomeWorksModel(subjectName: "Math" , title: "Solve this equation")])
                                // DashBoardHomeWork(list: myType.homeworks)
                              ],
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

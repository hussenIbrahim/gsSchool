import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/online_quizs/screen/online_quiz_widget.dart';
import 'package:testgsschoolst/screens/online_quizs/services/online_quiz_notifer.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';


class OnlineQuizScreen extends StatefulWidget {
  OnlineQuizScreen({Key key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<OnlineQuizScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // iconAndColorNotifer =
      //     Provider.of<IconAndColorNotifer>(context, listen: false);
      onlineQuizNotifer = Provider.of<OnlineQuizNotifer>(context, listen: false);
      if (onlineQuizNotifer.getDataStatus != Status.loading &&
          onlineQuizNotifer.subjects.length == 0) {
        onlineQuizNotifer.getSubectss(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await onlineQuizNotifer.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<OnlineQuizNotifer>(builder: (context, myType, child) {
              if (myType.getDataStatus == Status.loading ||
                  myType.getDataStatus == Status.initState) {
                return ProgressWidget();
              } else if (myType.getDataStatus == Status.error) {
                return FaliedLoadPageWIdget(
                    onPress: refresh, text: "Failed load Subjects");
              } else if (myType.getDataStatus == Status.newtworkError) {
                return NetWorkErrorWidget(
                    onPress: refresh, text: "Failed load Subjects");
              } else if (myType.getDataStatus == Status.noDataFound) {
                return NoDataFound(onPress: refresh, text: "No Subjects Found");
              } else if (myType.getDataStatus == Status.dataFound) {
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: refresh,
                            child:  
                            ListView.separated(
                              itemCount: myType.subjects.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  OnlineQuiz(
                                model: myType.subjects[index],
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            )
                            )),
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

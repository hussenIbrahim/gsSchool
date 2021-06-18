import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/subjects/screen/subject_widget.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_notifer.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class SubjectsScreen extends StatefulWidget {
  SubjectsScreen({Key key}) : super(key: key);

  @override
  _BehaveScreenState createState() => _BehaveScreenState();
}

class _BehaveScreenState extends State<SubjectsScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // iconAndColorNotifer =
      //     Provider.of<IconAndColorNotifer>(context, listen: false);
      subJectsNotifer = Provider.of<SubJectsNotifer>(context, listen: false);
      if (subJectsNotifer.getDataStatus != Status.loading &&
          subJectsNotifer.subjects.length == 0) {
        subJectsNotifer.getSubectss(false);
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await subJectsNotifer.refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<SubJectsNotifer>(builder: (context, myType, child) {
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
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              itemCount: myType.subjects.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  SubjectWidget(
                                model: myType.subjects[index],
                              ),
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(1),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                            )

                            // ListView.separated(
                            //   itemCount: myType.subjects.length,
                            //   itemBuilder: (BuildContext context, int index) =>
                            //       SubjectWidget(
                            //     model: myType.subjects[index],
                            //   ),
                            //   separatorBuilder:
                            //       (BuildContext context, int index) {
                            //     return Divider();
                            //   },
                            // )
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

import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class DashBoardHomeWork extends StatefulWidget {
  DashBoardHomeWork({Key key, @required this.list}) : super(key: key);
  final List<HomeWorksModel> list;
  @override
  _TodaySchdulingScreenState createState() => _TodaySchdulingScreenState();
}

class _TodaySchdulingScreenState extends State<DashBoardHomeWork> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translate.todayHomeworks.trans(),
            style: TextStyle(fontSize: Responsive().setSp(18)),
          ),
          widget.list.length == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        Translate.nodatafound.trans(),
                        style: TextStyle(
                            fontSize: Responsive().setSp(15),
                            color: Colors.red),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          for (var item in widget.list)
            _TodaySchdulingCard(
              model: item,
            )
        ],
      ),
    );
  }
}

class _TodaySchdulingCard extends StatelessWidget {
  const _TodaySchdulingCard({
    Key key,
    @required this.model,
  }) : super(key: key);
  final HomeWorksModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            child: ListTile(
      title: Text("${model.title}"),
      subtitle: Text("${model.subjectName}"),
    )));
  }
}

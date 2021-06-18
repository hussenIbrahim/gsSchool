import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_model.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final ScheduleModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Row(
        children: [
          SizedBox(
            width: Responsive().setWidth(100),
            height: Responsive().setWidth(100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  color: Colors.grey,
                  child: LessonImage.contains(model.subjectName)
                      ? Image.asset(
                          "assets/images/${model.subjectName}.png",
                          fit: BoxFit.cover,
                        )
                      : Text("${model.subjectName[0]}")),
            ),
          ),
          Container(
            width:
                MediaQuery.of(context).size.width - Responsive().setWidth(110),
            padding: const EdgeInsets.only(left: 8, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${model.subjectName}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(25),
                            color:
                                Theme.of(context).textTheme.subtitle2.color)),
                    Text("${model.dayName}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(12),
                            color:
                                Theme.of(context).textTheme.subtitle1.color)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${model.lessonNo}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(30),
                            color: Colors.red)),
                    Text("Teacher : ${model.teacherName}",
                        style: TextStyle(
                            fontSize: Responsive().setSp(16),
                            color:
                                Theme.of(context).textTheme.subtitle1.color)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_model.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class AttendanceWidget extends StatelessWidget {
  const AttendanceWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final AttendanceModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).secondaryHeaderColor,
              alignment: Alignment.center,
              child: Text("${model.attendanceType}",
                  style: TextStyle(
                      fontSize: Responsive().setSp(20),
                      color: Theme.of(context).textTheme.subtitle2.color)),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text("${model.subjectName}",
                    style: TextStyle(fontSize: Responsive().setSp(20))),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${model.date}",
                    style: TextStyle(fontSize: Responsive().setSp(15))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:testgsschoolst/screens/behave/services/behave_model.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class BehaveWidget extends StatelessWidget {
  const BehaveWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final BehaveModel model;
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
              child: Text("${model.subjectName}",
                  style: TextStyle(
                      fontSize: Responsive().setSp(20),
                      color: Theme.of(context).textTheme.subtitle2.color)),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text("${model.behaveType}",
                    style: TextStyle(fontSize: Responsive().setSp(20))),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            if (model.note != null && model.note.isNotEmpty)
              Row(
                children: [
                  Text("${model.behaveType}",
                      style: TextStyle(fontSize: Responsive().setSp(20))),
                ],
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

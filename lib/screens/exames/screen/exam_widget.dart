import 'package:flutter/material.dart';
import 'package:testgsschoolst/screens/exames/services/exames_mode.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class ExameWidget extends StatelessWidget {
  const ExameWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final ExamesModel model;
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: Responsive().setHeight(200),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Responsive().setWidth(25)),
            Text("${model.examTitle}",
                style: TextStyle(fontSize: Responsive().setSp(22))),
            SizedBox(height: Responsive().setWidth(15)),
            Text("${model.description}",
                style: TextStyle(fontSize: Responsive().setSp(22))),
            SizedBox(height: Responsive().setWidth(15)),
            Text("${model.dateOfExam.toString()}",
                style: TextStyle(fontSize: Responsive().setSp(22)))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/student/services/student_model.dart';
import 'package:testgsschoolst/screens/student/services/student_notifer.dart';

class StudentWidget extends StatefulWidget {
  @override
  _StudentWidgetState createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      studentNotifer = Provider.of<StudentNotifer>(context, listen: false);
      studentNotifer.getPicksForYouOffers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Consumer<StudentNotifer>(builder: (context, myType, child) {
            if (myType.getDataStatus == Status.loading ||
                myType.getDataStatus == Status.initState) {
              return CircularProgressIndicator();
            } else if (myType.getDataStatus == Status.error) {
              return Text("Failed load Student");
            } else if (myType.getDataStatus == Status.newtworkError) {
              return Text("Failed load Student");
            } else if (myType.getDataStatus == Status.noDataFound) {
              return Text("No Student Student");
            } else if (myType.getDataStatus == Status.dataFound) {
              return SizedBox(
                width: 200,
                child: DropdownButtonFormField(
                  items: myType.students.map((StudentModel category) {
                    return new DropdownMenuItem(
                        value: category.id,
                        child: Row(
                          children: <Widget>[
                            Text(
                                "${category.firstName ?? ''}"),
                          ],
                        ));
                  }).toList(),
                  onChanged: (String newValue) {
                    myType.changeStudent(newValue);
                  },
                  value: myType.student?.id,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    filled: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: Colors.grey[200],
                    hintText: "Select Student",
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
        ),
        InkWell(
            child: Icon(Icons.refresh),
            onTap: () {
              studentNotifer.refresh();
            }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:testgsschoolst/screens/subjects/screen/editIconalert.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final SubjectModel model;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: Responsive().setHeight(200),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Responsive().setWidth(25)),
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    model.image ?? "assets/images/def.jpg",
                    width: Responsive().setWidth(90),
                    height: Responsive().setWidth(90),
                  ), //  Icon(
                  //   IconData(model.icon, fontFamily: 'MaterialIcons'),
                  //   size: Responsive().setSp(80),
                  //   color: Color(model.color),
                  // ),
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: theme.secondaryHeaderColor),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                        onTap: () {
                         selectImageForSubjects(context ,model);
                        },
                        child: CircleAvatar(
                            backgroundColor: theme.secondaryHeaderColor,
                            child: Icon(Icons.edit))))
              ],
            ),
            SizedBox(height: Responsive().setWidth(15)),
            Text("${model.name}",
                style: TextStyle(fontSize: Responsive().setSp(22)))
          ],
        ),
      ),
    );
  }
}

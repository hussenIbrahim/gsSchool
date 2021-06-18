import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_services.dart';
import 'package:testgsschoolst/widget/responsev.dart';

selectImageForSubjects(context, SubjectModel model) {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return SafeArea(
          maintainBottomViewPadding: true,
          top: true,
          child: Container(
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 25, right: 25),
                    margin: EdgeInsets.zero,
                    decoration: new BoxDecoration(
                        color: Theme.of(navigatorKey.currentContext)
                            .secondaryHeaderColor,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(9.0),
                            topRight: const Radius.circular(9.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Translate.selectImage.trans(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Responsive().setSp(
                              24,
                            ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/2,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: assests.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                locator<SubjectsServices>().upDateSubjects(
                                    model..image = assests[index]);
                                    Navigator.pop(context);
                              },
                              child: Row(children: [
                                Image.asset(
                                  assests[index],
                                  width: Responsive().setWidth(75),
                                  height: Responsive().setWidth(75),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("${assests[index].split("/").last}")
                              ]),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )),
        );
      });
}

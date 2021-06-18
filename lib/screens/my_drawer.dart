import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/repo/theme.dart';
import 'package:testgsschoolst/screens/account/screens/account_setting.dart';
import 'package:testgsschoolst/screens/account/screens/accounts_screen.dart';
import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';
import 'package:testgsschoolst/screens/prepare.dart';
import 'package:testgsschoolst/screens/student/screen/student_widget.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:testgsschoolst/widget/net_image_cheker.dart';
import 'package:testgsschoolst/widget/responsev.dart';

import '../../locator.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive().setWidth(300),
      child: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            Consumer<ThemeNotifier>(
              builder: (context, myType, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: Responsive().setWidth(
                          8,
                        ),
                      ),
                      InkWell(
                        child: Transform.rotate(
                          angle: 100,
                          child: Icon(
                              myType.isDark
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny,
                              color: myType.isDark
                                  ? Colors.white
                                  : Colors.yellow[800],
                              size: Responsive().setSp(26)),
                        ),
                        onTap: () {
                          myType.changeThemeMod(!myType.isDark);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            // Consumer<PersonalInfoNotifier>(builder: (context, myType, child) {
            //   print(" attachment ${myType.accountModel.image}");

            //   return InkWell(
            //     child: Center(
            //       child: Container(
            //         width: Responsive().setWidth(125),
            //         height: Responsive().setWidth(125),
            //         child: Container(
            //           width: Responsive().setWidth(125),
            //           height: Responsive().setWidth(125),
            //           decoration: new BoxDecoration(
            //             color: Colors.grey,
            //             shape: BoxShape.circle,
            //           ),
            //           child: ClipOval(
            //               clipBehavior: Clip.hardEdge,
            //               child: myType.accountModel.image != null &&
            //                       myType.accountModel.image != "null"
            //                   ? NetImageChecker(
            //                       errorImage: 'assets/images/profile_image.png',
            //                       linkImage: "${myType.accountModel.image}",
            //                       tempImage: 'assets/images/profile_image.png',
            //                       boxFit: BoxFit.cover,
            //                     )
            //                   : Image.asset('assets/images/profile_image.png')),
            //         ),
            //       ),
            //     ),
            //   );
            // }),
            // SizedBox(height: 25),
            InkWell(
              child: Container(
                child: Consumer<PersonalInfoNotifier>(
                  builder: (context, myType, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Center(
                            child: Container(
                              width: Responsive().setWidth(75),
                              height: Responsive().setWidth(75),
                              child: Container(
                                width: Responsive().setWidth(75),
                                height: Responsive().setWidth(75),
                                decoration: new BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                AccountSettingScreen()));
                                  },
                                  child: ClipOval(
                                      clipBehavior: Clip.hardEdge,
                                      child: myType.accountModel.image !=
                                                  null &&
                                              myType.accountModel.image !=
                                                  "null"
                                          ? NetImageChecker(
                                              errorImage:
                                                  'assets/images/profile_image.png',
                                              linkImage:
                                                  myType.accountModel.image,
                                              tempImage:
                                                  'assets/images/profile_image.png',
                                              boxFit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/profile_image.png')),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${myType.accountModel.firstName ?? ''} ${myType.accountModel.lastName ?? ''}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Responsive().setSp(22),
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(Icons.settings),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  AccountListScreen()));
                                    },
                                  )
                                ],
                              ),
                            ),
                            myType.accountModel.userType == "Parent"
                                ? StudentWidget()
                                : SizedBox()
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.dashBoard);
              },
              leading: Icon(Icons.dashboard, size: Responsive().setSp(24)),
              title: Text(
                Translate.dashboard.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.homeWOrk);
              },
              leading:
                  Icon(Icons.home_work_outlined, size: Responsive().setSp(24)),
              title: Text(
                Translate.homeworks.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.schedule);
              },
              leading:
                  Icon(Icons.schedule_outlined, size: Responsive().setSp(24)),
              title: Text(
                Translate.schedule.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.subjects);
              },
              leading:
                  Icon(Icons.schedule_outlined, size: Responsive().setSp(24)),
              title: Text(
                Translate.subjects.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.books);
              },
              leading: Icon(Icons.book, size: Responsive().setSp(24)),
              title: Text(
                Translate.books.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.exams);
              },
              leading: Icon(Icons.quiz, size: Responsive().setSp(24)),
              title: Text(
                Translate.exams.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.onlineQuiz);
              },
              leading: Icon(Icons.quiz, size: Responsive().setSp(24)),
              title: Text(
                Translate.onlineQuizes.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.events);
              },
              leading: Icon(Icons.event, size: Responsive().setSp(24)),
              title: Text(
                Translate.events.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.schoolInfo);
              },
              leading: Icon(Icons.info, size: Responsive().setSp(24)),
              title: Text(
                Translate.schoolInfo.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.behaveAndAttendance);
              },
              leading: Icon(Icons.person, size: Responsive().setSp(24)),
              title: Text(
                Translate.behave.trans() + " " + Translate.attendence.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),

            ListTile(
              onTap: () async {
                Navigator.pop(context);
                prepareAppNotifier.changeIndex(ScreenEnums.gpsTracker);
              },
              leading: Icon(Icons.map_outlined, size: Responsive().setSp(24)),
              title: Text(
                Translate.gPSTracker.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Responsive().setSp(15),
            ),
            ListTile(
              onTap: () async {
                showLoadingProgressAlert();
                signOut();
              },
              leading:
                  Icon(Icons.power_settings_new, size: Responsive().setSp(24)),
              title: Text(
                Translate.logOut.trans(),
                style: TextStyle(
                  fontSize: Responsive().setSp(
                    17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

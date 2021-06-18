import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/connection.dart';
import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';
import 'package:testgsschoolst/screens/app_bar.dart';
import 'package:testgsschoolst/screens/behave/screen/behave_attendance_screen.dart';
import 'package:testgsschoolst/screens/books/screen/books_screen.dart';
import 'package:testgsschoolst/screens/dash_board/screen/first_dash_board.dart';
import 'package:testgsschoolst/screens/events/screen/evetns_screen.dart';
import 'package:testgsschoolst/screens/exames/screen/exames_screen.dart';
import 'package:testgsschoolst/screens/gps_tracker/screens/screen.dart';
import 'package:testgsschoolst/screens/homeworks/screen/homeworks_screen.dart';
import 'package:testgsschoolst/screens/my_drawer.dart';
import 'package:testgsschoolst/screens/online_quizs/screen/online_quiz_screen.dart';
import 'package:testgsschoolst/screens/prepare.dart';
import 'package:testgsschoolst/screens/schedule/screen/schedule_screen.dart';
import 'package:testgsschoolst/screens/school_info/screens/screen.dart';
import 'package:testgsschoolst/screens/subjects/screen/subjects_screen.dart';

import 'account/screens/select_image_profile.dart';
import 'books/services/books_notifer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homePageController = PageController();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      attachmentNotifier =
          Provider.of<AttachmentNotifier>(context, listen: false);
      prepareAppNotifier =
          Provider.of<PrepareAppNotifier>(context, listen: false);
      booksNotifer = Provider.of<BooksNotifer>(context, listen: false);

      personalInfoNotifier =
          Provider.of<PersonalInfoNotifier>(context, listen: false);
      connectionNotifer =
          Provider.of<ConnectionNotifer>(context, listen: false);
      subJectsNotifer.getSubectss(false);
    });
    super.initState();
  }

  @override
  void dispose() {
    homePageController.dispose();
    super.dispose();
  }

  // Future<void> _refresh() async {
  //   await dashBoardNotifer.refresh();
  // }
  final _pages = [
    FirstDashBoard(),
    HomeWorkScreen(),
    ScheduleScreen(),
    OnlineQuizScreen(),
    EventsScreen(),
    SchoolInfoScreen(),
    ExamesScreen(),
    Container(),
    BehaveAbdAttendanceScreen(),
    GpsTrackerScreen(),
    BooksScreen(),
    SubjectsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(actions: []),
        drawer: MyDrawer(),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: PageView(
            controller: homePageController,
            physics: NeverScrollableScrollPhysics(),
            children: _pages),
      ),
    );
  }
}

PageController homePageController;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/chat_screen/screens/chat_screen.dart';
import 'package:testgsschoolst/screens/dash_board/screen/dash_board_screen.dart';
import 'package:testgsschoolst/screens/dash_board/services/dash_board_notifer.dart';
import 'package:testgsschoolst/screens/prepare.dart';

class FirstDashBoard extends StatefulWidget {
  @override
  _FirstDashBoardState createState() => _FirstDashBoardState();
}

class _FirstDashBoardState extends State<FirstDashBoard> {
  @override
  void initState() {
    controller = PageController();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      dashBoardNotifer = Provider.of<DashBoardNotifer>(context, listen: false);
      if ((dashBoardNotifer.getDataStatus != Status.loading &&
          dashBoardNotifer.offersList.length == 0)) {
        dashBoardNotifer.getBooks(false);
      }
    });
    super.initState();
  }

  PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [DashBoard(), ChatScreen()],
      ),
      bottomNavigationBar:
          Consumer<PrepareAppNotifier>(builder: (context, myType, child) {
        return BottomNavigationBar(
          onTap: (int index) {
            controller.jumpToPage(index);
            myType.changeDashBoardIndex(index);
          },
          currentIndex: myType.dashboardIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: Translate.dashboard.trans()),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: Translate.chatpage.trans()),
          ],
        );
      }),
    );
  }
}

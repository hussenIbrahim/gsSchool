import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/chat_screen/screens/messages.dart';
import 'package:testgsschoolst/screens/chat_screen/screens/person_card.dart';
import 'package:testgsschoolst/screens/chat_screen/services/chat_notifer.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      chatNotifer = Provider.of<ChatNotifer>(context, listen: false);
      if (chatNotifer.getDataStatus != Status.loading &&
          chatNotifer.offersList.length == 0) {
        chatNotifer.getPicksForYouOffers();
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    await chatNotifer.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<ChatNotifer>(builder: (context, myType, child) {
            if (myType.getDataStatus == Status.loading ||
                myType.getDataStatus == Status.initState) {
              return ProgressWidget();
            } else if (myType.getDataStatus == Status.error) {
              return FaliedLoadPageWIdget(
                  onPress: refresh, text: "Failed load Chats");
            } else if (myType.getDataStatus == Status.newtworkError) {
              return NetWorkErrorWidget(
                  onPress: refresh, text: "Failed load Chats");
            } else if (myType.getDataStatus == Status.noDataFound) {
              return NoDataFound(onPress: refresh, text: "No chats Found");
            } else if (myType.getDataStatus == Status.dataFound) {
              return Column(
                children: [
                  Expanded(
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (myType.paginations !=
                                    PaginationStatus.loading &&
                                myType.paginations !=
                                    PaginationStatus.matchToEnd &&
                                myType.getDataStatus != Status.loading &&
                                myType.getDataStatus != Status.initState &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              myType.changePaginationStatus(
                                  PaginationStatus.loading);

                              myType.getPicksForYouOffers();
                            }

                            return true;
                          },
                          child: RefreshIndicator(
                              onRefresh: refresh,
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 1,
                                itemCount: myType.offersList.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ChatCard(
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MessagesScreen(
                                                message:
                                                    myType.offersList[index])));
                                  },
                                  chat: myType.offersList[index],
                                ),
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.fit(1),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                              )))),
                  myType.paginations == PaginationStatus.loading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : Container()
                ],
              );
            } else {
              return ProgressWidget();
            }
          }),
        ),
      ],
    );
  }
}

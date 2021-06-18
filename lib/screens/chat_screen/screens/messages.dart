import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/chat_screen/screens/chat_buble.dart';
 import 'package:testgsschoolst/screens/chat_screen/screens/text_filed.dart';
import 'package:testgsschoolst/screens/chat_screen/services/messages_notifer.dart';
import 'package:testgsschoolst/screens/chat_screen/services/person_model.dart';
import 'package:testgsschoolst/widget/state_widget/falied_load_page_widget.dart';
import 'package:testgsschoolst/widget/state_widget/network_error.dart';
import 'package:testgsschoolst/widget/state_widget/no_data_found.dart';
import 'package:testgsschoolst/widget/state_widget/progress_widget.dart';

class MessagesScreen extends StatefulWidget {
  final Messages message;

  const MessagesScreen({Key key,@required this.message}) : super(key: key);
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      messagesNotifer = Provider.of<MessagesNotifer>(context, listen: false);
   
        messagesNotifer.getPicksForYouOffers(widget.message.forUser);
    
    });
    super.initState();
  }

  Future<void> refresh() async {
    await messagesNotifer.refresh(widget.message.forUser);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<MessagesNotifer>(builder: (context, myType, child) {
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

                              myType.getPicksForYouOffers(widget.message.forUser);
                            }

                            return true;
                          },
                          child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.builder(
                              itemCount: myType.messagesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Message(
                                    message: myType.messagesList[index]);
                              },
                            ),
                          ))),
                  myType.paginations == PaginationStatus.loading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                  ChatInputField(),
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

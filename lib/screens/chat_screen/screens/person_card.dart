import 'package:flutter/material.dart';
import 'package:testgsschoolst/screens/chat_screen/services/person_model.dart';
import 'package:testgsschoolst/widget/net_image_cheker.dart';
import 'package:testgsschoolst/widget/responsev.dart';

const kDefaultPadding = 20.0;

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key key,
    @required this.chat,
    @required this.press,
  }) : super(key: key);

  final Messages chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child: chat.picPath == null
                      ? Text(
                          "${chat.firstName[0]} ${chat.lastName[0]}",
                          style: TextStyle(color: Colors.white),
                        )
                      : NetImageChecker(
                          linkImage: chat.picPath,
                          tempImage: "assets/images/profile_image.png",
                          boxFit: BoxFit.cover,
                          errorImage: "assets/images/profile_image.png"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${chat.firstName ?? ''} ${chat.lastName ?? ''}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              "${chat.lastMessageText ?? ''}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            child: Text("${chat.lastConversationTime}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: Responsive().setSp(12))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

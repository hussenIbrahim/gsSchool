import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/chat_screen/screens/person_card.dart';
import 'package:testgsschoolst/screens/chat_screen/services/person_model.dart';

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Messages message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
            message.forUser == personalInfoNotifier.accountModel.id
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          if (!(message.forUser == personalInfoNotifier.accountModel.id)) ...[
            CircleAvatar(
              radius: 12,
              // backgroundImage: AssetImage("assets/images/user_2.png"),
            ),
            SizedBox(width: kDefaultPadding / 2),
          ],
          TextMessage(message: message),
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final Messages message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(
            message.forUser == personalInfoNotifier.accountModel.id ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "${message.lastMessageText}",
        style: TextStyle(
          color: message.forUser == personalInfoNotifier.accountModel.id
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }
}

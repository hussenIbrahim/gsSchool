import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/account/services/account_model.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    Key key,
    @required this.chat,
    @required this.setAsPrimary,
    @required this.onLongPress,
  }) : super(key: key);

  final AccountModel chat;
  final VoidCallback setAsPrimary;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    myPrint(" chat.isPrimary ${chat.isPrimary}");
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        color: chat.isPrimary == true ? Colors.amber : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${chat.firstName ?? ''} ${chat.lastName ?? ''}",
                      style: TextStyle(
                          fontSize: Responsive().setSp(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "${chat.userType ?? ''}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive().setSp(18),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${chat.userName ?? ''}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive().setSp(18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Icon(chat.isPrimary == true
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
                onTap: setAsPrimary,
              )
            ],
          ),
        ),
      ),
    );
  }
}

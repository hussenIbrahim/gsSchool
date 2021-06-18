import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';

import 'package:testgsschoolst/screens/events/services/event_model.dart';
import 'package:testgsschoolst/widget/net_image_cheker.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({
    Key key,
    @required this.model,
  }) : super(key: key);
  final EventModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            color: Theme.of(context).secondaryHeaderColor,
            child: Text("${model.eventTitle}",
                style: TextStyle(fontSize: Responsive().setSp(20))),
          ),
          SizedBox(
            height: 5,
          ),
          Text("${model.description}",
              style: TextStyle(fontSize: Responsive().setSp(20))),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getText(
                    "${Translate.startDate.trans()}",
                    "${model.startDate.toString().split(" ")[0]}",
                    Theme.of(context).textTheme.bodyText1),
                getText(
                    "${Translate.endDate.trans()}",
                    "${model.endDate.toString().split(" ")[0]}",
                    Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          if (model.hasAttachment == true)
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: NetImageChecker(
                    linkImage: model.attachment,
                    boxFit: BoxFit.fill,
                    errorImage: "assets/images/error.jpg",
                    tempImage: "assets/images/error.jpg",
                  )),
            ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget getText(String str1, String str2, TextStyle style) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '$str1\n',
        style: style,
        children: <TextSpan>[
          TextSpan(text: '$str2', style: TextStyle()),
        ],
      ),
    );
  }
}

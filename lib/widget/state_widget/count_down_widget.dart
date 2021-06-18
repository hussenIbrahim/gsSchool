import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class CountdownDemo extends StatefulWidget {
  final int endTime;

  CountdownDemo(this.endTime);

  @override
  _CountdownDemoState createState() => _CountdownDemoState();
}

class _CountdownDemoState extends State<CountdownDemo> {
  CountdownTimerController countdownTimerController;

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: countdownTimerController,
      widgetBuilder: (context, t) {
        return Text(
            "${Translate.endAt.trans()} ${t?.days ?? '0'} ${Translate.days.trans()} ${t?.hours ?? '00'}:${t?.min ?? '00'}:${t?.sec ?? '00'}",
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: Responsive().setSp(14)));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    countdownTimerController =
        CountdownTimerController(endTime: widget.endTime);
  }
}

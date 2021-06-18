import 'package:flutter/material.dart';

class CostDivider extends StatelessWidget {
  const CostDivider({
    Key key,
    this.height = 0,
  }) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Divider(
        height: height == 0 ? null : height,
        color: txtTheme.caption.color,
      ),
    );
  }
}

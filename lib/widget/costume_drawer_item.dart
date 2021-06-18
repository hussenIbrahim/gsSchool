import 'package:flutter/material.dart';

class CostumeDrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const CostumeDrawerItem({
    Key key,
    this.icon,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 33,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

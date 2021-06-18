import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/screens/account/services/account_model.dart';
import 'package:testgsschoolst/widget/responsev.dart';

showAccountActionBottomSheet(context, int index, AccountModel model) {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return SafeArea(
          maintainBottomViewPadding: true,
          top: true,
          child: Container(
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 25, right: 25),
                    margin: EdgeInsets.zero,
                    decoration: new BoxDecoration(
                        color: Theme.of(navigatorKey.currentContext)
                            .secondaryHeaderColor,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(9.0),
                            topRight: const Radius.circular(9.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Translate.selectImage.trans(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Responsive().setSp(
                              24,
                            ))),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.delete,
                      size: Responsive().setSp(30),
                    ),
                    title: new Text(
                      Translate.deleteAccount.trans(),
                      style: TextStyle(fontSize: Responsive().setSp(20)),
                    ),
                    onTap: () async {
                      Navigator.pop(navigatorKey.currentContext);
                      personalInfoNotifier.deleteAccount(model, index);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new ListTile(
                    leading: new Icon(
                      Icons.favorite_border_outlined,
                      size: Responsive().setSp(30),
                    ),
                    
                    title: new Text(
                      Translate.primary.trans(),
                      style: TextStyle(fontSize: Responsive().setSp(20)),
                    ),
                    onTap: () async {
                      Navigator.pop(navigatorKey.currentContext);
                      personalInfoNotifier.setAsPrimary(model, index);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )),
        );
      });
}

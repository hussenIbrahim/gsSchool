import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/account/screens/account_bottom_sheet.dart';
import 'package:testgsschoolst/screens/account/screens/account_widget.dart';
import 'package:testgsschoolst/screens/account/screens/add_new_account_bottom_sheet.dart';
import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';

class AccountListScreen extends StatefulWidget {
  AccountListScreen({Key key}) : super(key: key);

  @override
  _AccountListScreenState createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Accounts"),
          centerTitle: true,
        ),
        body: Container(child:
            Consumer<PersonalInfoNotifier>(builder: (context, myType, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: myType.accounts.length,
                    itemBuilder: (context, index) {
                      return AccountWidget(
                        onLongPress: () {
                          onLongPress(index, myType.accounts[index]);
                        },
                        chat: myType.accounts[index],
                        setAsPrimary: () {
                          setAsPrimary(index, myType.accounts[index]);
                        },
                      );
                    }),
              ),
            ],
          );
        })),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addNewAccountBottomSheet(context);
          },
        ),
      ),
    );
  }

  setAsPrimary(index, model) async {
    setValuesToDefalut();
    personalInfoNotifier.setAsPrimary(model, index);
  }

  onLongPress(index, model) async {
    showAccountActionBottomSheet(context, index, model);
  }
}

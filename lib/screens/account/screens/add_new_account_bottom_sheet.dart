import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';

import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/repo/validations.dart';
import 'package:testgsschoolst/screens/account/services/login_services.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/simple_button.dart';

addNewAccountBottomSheet(context) {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return AddNewAccount();
      });
}

class AddNewAccount extends StatefulWidget {
  @override
  _AddNewAccountState createState() => _AddNewAccountState();
}

class _AddNewAccountState extends State<AddNewAccount> {
  TextEditingController _phoneNumber;
  TextEditingController _password;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _phoneNumber = TextEditingController();
    _password = TextEditingController();
  }

  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: "werthjyusdfsdjyhregwghtujyhtge");

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text("Add new account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: Responsive().setSp(
                        24,
                      ))),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: TextFormField(
                      controller: _phoneNumber,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateName,
                      decoration: InputDecoration(
                          hintText: Translate.userName.trans(),
                          prefixIcon: Icon(
                            Icons.person_outline_sharp,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      obscureText: !isVisible,
                      controller: _password,
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        hintText: Translate.password.trans(),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: SimpleButton(
                          color: Theme.of(context).primaryColor,
                          text: Translate.addAccount.trans(),
                          onPres: () {
                            _handleLogin();
                          },
                          width: MediaQuery.of(context).size.width / 3,
                          hight: Responsive().setHeight(60),
                          fontSize: Responsive().setSp(20),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: SimpleButton(
                            width: MediaQuery.of(context).size.width / 3,
                            color: Colors.red,
                            text: Translate.cancel.trans(),
                            onPres: () {
                            Navigator.pop(context);
                            },
                            fontSize: Responsive().setSp(20),
                            txtColor: Colors.white,
                            hight: Responsive().setHeight(60)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      showLoadingProgressAlert();
      Future.delayed(Duration(seconds: 1)).then((value) async {
        LoginServices loginServices = locator<LoginServices>();
        loginServices.addNewAccount(
            username: _phoneNumber.text, password: _password.text);
      });
    }
  }
}

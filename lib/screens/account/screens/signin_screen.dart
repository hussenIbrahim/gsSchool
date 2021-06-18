import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/repo/theme.dart';
import 'package:testgsschoolst/repo/validations.dart';
import 'package:testgsschoolst/screens/account/services/login_services.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/simple_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            Translate.login.trans(),
                            style: TextStyle(fontSize: Responsive().setSp(25)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            Translate.studentsAndParents.trans(),
                            style: TextStyle(fontSize: Responsive().setSp(17)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: TextFormField(
                                  controller: _phoneNumber,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: validatePassword,
                                  decoration: InputDecoration(
                                    hintText: Translate.password.trans(),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 30),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: SimpleButton(
                                      fontSize: Responsive().setSp(20),
                                      txtColor: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                      text: Translate.login.trans(),
                                      onPres: () {
                                        _handleLogin();
                                      },
                                      hight: Responsive().setHeight(60)),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                              ),
                              Consumer<ThemeNotifier>(
                                  builder: (context, myType, child) {
                                return PopupMenuButton<String>(
                                    onSelected: (String result) {
                                      myType.changeLang(result);
                                    },
                                    child: Text(getLang(myType.lang)),
                                    itemBuilder: (BuildContext context) =>
                                        languagesList
                                            .map((e) => PopupMenuItem<String>(
                                                  value: e.code,
                                                  child: Text(e.lang.trans()),
                                                ))
                                            .toList());
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      showLoadingProgressAlert();
      Future.delayed(Duration(seconds: 1)).then((value) async {
        LoginServices loginServices = locator<LoginServices>();
        loginServices.logIn(
            username: _phoneNumber.text, password: _password.text);
      });
    }
  }
}

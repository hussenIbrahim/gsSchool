import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/validations.dart';
import 'package:testgsschoolst/screens/account/services/login_services.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/textV_filed.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currrentPassword;
  TextEditingController _newPassword;
  TextEditingController _confermNewPassword;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>(debugLabel: "erdrgdfgdaterg");
    _currrentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _confermNewPassword = TextEditingController();
    super.initState();
  }

  FocusNode _passNode = new FocusNode();
  FocusNode _phoen2Node = new FocusNode();
  FocusNode _noteNode = new FocusNode();
  GlobalKey<FormState> _formKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translate.changePassword.trans(), style: TextStyle()),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  ComesTextFiled(
                    keyBoradType: TextInputType.name,
                    controller: _currrentPassword,
                    hintText: Translate.oldPassword.trans(),
                    inputFormatters: [],
                    validator: validatePassword,
                    focusNode: _passNode,
                    onSubmit: (str) {
                      _phoen2Node.requestFocus();
                    },
                  ),
                  ComesTextFiled(
                    keyBoradType: TextInputType.name,
                    controller: _newPassword,
                    hintText: Translate.newPassword.trans(),
                    inputFormatters: [],
                    focusNode: _phoen2Node,
                    validator: validatePassword,
                    onSubmit: (str) {
                      _noteNode.requestFocus();
                    },
                  ),
                  ComesTextFiled(
                    keyBoradType: TextInputType.name,
                    controller: _confermNewPassword,
                    hintText: Translate.confirmPasswrod.trans(),
                    inputFormatters: [],
                    focusNode: _noteNode,
                    validator: validatePassword,
                    onSubmit: (str) {
                      reset();
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      reset();
                    },
                    child: Container(
                        width: Responsive().setWidth(150),
                        height: Responsive().setWidth(50),
                        padding: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: new BorderRadius.circular(45.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Translate.save.trans(),
                          style: TextStyle(
                            color: Theme.of(context).selectedRowColor,
                            fontSize: Responsive().setSp(
                              20,
                            ),
                          ),
                        )),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> reset() async {
    if (connectionNotifer.isConnected != true) {
      showToast(Translate.connectToNetAndRetryAgain.trans());
      return;
    }
    String oldPassword = _currrentPassword.text.trim();
    String newPassword = _newPassword.text.trim();
    String confermNewPassword = _confermNewPassword.text.trim();
    myPrint(
        "oldPassword $oldPassword  newPassword $newPassword  confermNewPassword $confermNewPassword");
    if (_formKey.currentState.validate()) {
      if (confermNewPassword == newPassword) {
        showLoadingProgressAlert();
        LoginServices loginServices = locator<LoginServices>();

        loginServices.changePasswordMiddleWare(
          data: {
            "currentPassword": oldPassword,
            "password": newPassword,
            "confirmPassword": confermNewPassword
          },
        );
      } else {
        showToast(Translate.newPasswordNotMatchWithConferm.trans());
      }
    }
  }
}

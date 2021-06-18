import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/repo/validations.dart';
import 'package:testgsschoolst/screens/account/services/account_model.dart';
import 'package:testgsschoolst/screens/account/services/account_services.dart';
import 'package:testgsschoolst/widget/alerts/loading_alert.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';
import 'package:testgsschoolst/widget/responsev.dart';
import 'package:testgsschoolst/widget/textV_filed.dart';

import '../../../locator.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  TextEditingController firstName;
  TextEditingController middleName;
  TextEditingController lastName;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    firstName = TextEditingController(
        text: personalInfoNotifier.accountModel.firstName);
    middleName = TextEditingController(
        text: personalInfoNotifier.accountModel.middleName);
    lastName =
        TextEditingController(text: personalInfoNotifier.accountModel.lastName);
    super.initState();
  }

  FocusNode _firstNode = new FocusNode();
  FocusNode _secondNode = new FocusNode();
  FocusNode _thirdNode = new FocusNode();
  GlobalKey<FormState> _formKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(Translate.editname.trans(),
                style: TextStyle(fontSize: Responsive().setSp(22))),
            centerTitle: true),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                    ),
                    ComesTextFiled(
                      keyBoradType: TextInputType.name,
                      controller: firstName,
                      hintText: Translate.firstName.trans(),
                      focusNode: _secondNode,
                      inputFormatters: [],
                      validator: validateName,
                      onSubmit: (str) {
                        _thirdNode.requestFocus();
                      },
                    ),
                    ComesTextFiled(
                      focusNode: _thirdNode,
                      keyBoradType: TextInputType.name,
                      controller: middleName,
                      hintText: Translate.middleName.trans(),
                      inputFormatters: [],
                      validator: validateName,
                      onSubmit: (str) {
                        _firstNode.requestFocus();
                      },
                    ),
                    ComesTextFiled(
                      focusNode: _firstNode,
                      keyBoradType: TextInputType.name,
                      controller: lastName,
                      hintText: Translate.lastName.trans(),
                      inputFormatters: <TextInputFormatter>[],
                      validator: validateName,
                      onSubmit: (str) {
                        _handle();
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();

                        _handle();
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
                                18,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(height: 25),
                  ]),
                ),
              ),
            )),
      ),
    );
  }

  AccountServices accountServices = locator<AccountServices>();

  Future<void> _handle() async {
    if (_formKey.currentState.validate()) {
      AccountModel model = personalInfoNotifier.accountModel;
      if (model.firstName == "${firstName.text.trim()}" &&
          model.lastName == "${lastName.text.trim()}" &&
          model.middleName == "${middleName.text.trim()}") {
        showToast(Translate.noChangeTosave.trans());
      } else {
        showLoadingProgressAlert();

        final _firstName = "${firstName.text.trim()}";
        final _lastName = "${lastName.text.trim()}";
        final _middleName = "${middleName.text.trim()}";
        locator<AccountServices>().editPersonalInfoMiddleWare(
            firstName: _firstName,
            lastName: _lastName,
            middleName: _middleName);
      }
    }
  }
}

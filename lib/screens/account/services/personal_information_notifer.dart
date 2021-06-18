import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/account/services/account_model.dart';
import 'package:testgsschoolst/screens/account/services/multi_account_services.dart';

class PersonalInfoNotifier extends ChangeNotifier {
  AccountModel accountModel = locator<MultuAccountServices>().accountModel;
  List<AccountModel> accounts = locator<MultuAccountServices>().accounts;
  upDateAccountModel(AccountModel newAccountModel) {
    accountModel = newAccountModel;
    accounts.add(newAccountModel);
    locator<MultuAccountServices>().upDateStudent(accountModel);
    notifyListeners();
  }

  addAccountModel(AccountModel newAccountModel) {
    accounts.add(newAccountModel);
    notifyListeners();
  }

  setAsPrimary(AccountModel newAccountModel, int index) {
    accountModel = newAccountModel..isPrimary = true;
    accounts.forEach((element) {
      if (element.token == newAccountModel.token) {
        element.isPrimary = true;
      } else {
        element.isPrimary = false;
      }
    });
    locator<MultuAccountServices>()
        .upDateStudent(accountModel..isPrimary = true);
    notifyListeners();
  }

  deleteAccount(AccountModel model, int index) {
    locator<MultuAccountServices>().deleteAccount(model);
    accounts.removeWhere((item) => item.id == model.id);

    notifyListeners();
  }

  File fileImage;

  changeFileImage(File value) {
    fileImage = value;
    notifyListeners();
  }

  upDateName({AccountModel model}) {
    accountModel = model;

    locator<MultuAccountServices>().upDateStudent(accountModel);
    fileImage = null;

    notifyListeners();
  }

  changeSelectedAccount(AccountModel accountModelParam) {
    accountModel = accountModelParam;
    notifyListeners();
  }
}

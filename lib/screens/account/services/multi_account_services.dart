import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/account/services/account_model.dart';

class MultuAccountServices {
  List<AccountModel> accounts = [];

  AccountModel accountModel = new AccountModel();

  Future<void> initDatas() async {
    await getUserModel();

    return true;
  }

  saveStudents(List<AccountModel> list) async {
    final _db = await database;
    list.forEach((model) {
      _db.insert(AccountsTable, model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  upDateStudent(AccountModel model) async {
    accountModel = model;

    final _db = await database;
    _db.rawUpdate('UPDATE $AccountsTable SET isPrimary = ?  WHERE token != ?',
        [false, model.token]);
    _db.insert(AccountsTable, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteAccount(AccountModel model) async {
    final _db = await database;
    _db.rawDelete('DELETE FROM $AccountsTable WHERE id = ?', [model.id]);
  }

  getUserModel() async {
    final _db = await database;
    final List<Map<dynamic, dynamic>> data = await _db.query(AccountsTable);

    myPrint("mapmapmap  $data");
    if (data.isEmpty) {
      return;
    }
    data.forEach((
      key,
    ) {
      AccountModel temp =
          AccountModel.fromJson(Map<String, dynamic>.from(key), true);
      if (temp.isPrimary == true) {
        accountModel = temp;
      }
      accounts.add(temp);
    });
    myPrint("${accounts.length != 0} ${accountModel.token == null}");
    if (accounts.length != 0 && accountModel.token == null) {
      myPrint("accountModel ");
      accountModel = accounts.first;
    }
  }

  Future<void> clearAll() async {
    accountModel = AccountModel();
  }
}

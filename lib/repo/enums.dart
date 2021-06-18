import 'package:meta/meta.dart';
import 'package:testgsschoolst/localization/local_keys.dart';

enum Status {
  dataFound,
  loading,
  error,
  newtworkError,
  permissionError,
  initState,
  noDataFound,
  platformError,
  dataDeleted,
  phoneUsedByAnotherAccount,
  emailUserByAnotherAccount,
  cancelAble,
  cancled,

  falied,
  success,
  serverError,
  notAuthorized,
  weakPassword,
  notFoundError,
  alreadyExist,

  wrongPassword
}
enum Cunccreny { Dollar, Dinar, Defualt }

enum LoginStatus {
  loading,
  loaded,
  error,
  newtworkError,
  falied,
  success,
  inCorrectUsernameOrPass
}

class FiltteringBy {
  static const String Day = "Day";
  static const String Month = "Month";
  static const String Custome = "Custome";
  static const List<String> FiltteringByList = [Day, Month, Custome];
}

class StatusWithErrorMessage {
  String message;
  Status status;
  StatusWithErrorMessage({
    @required this.message,
    @required this.status,
  });
}

enum PaginationStatus {
  matchToEnd,
  loading,
  notMatch,
}
enum LoadNewData { fromLocal, loaded, updated, unKnown }

class Lanugages {
  String lang;
  String code;
  Lanugages({
    @required this.lang,
    @required this.code,
  });
}

var languagesList = [
  Lanugages(code: "ku", lang: Translate.kurdish),
  Lanugages(code: "ar", lang: Translate.arabic),
  Lanugages(code: "en", lang: Translate.english),
  Lanugages(code: "pa", lang: 'Farsi'),
  Lanugages(code: "tr", lang: 'Turkish'),
];
String getLang(String code) {
  switch (code) {
    case "ku":
      return Translate.kurdish;
      break;
    case "ar":
      return Translate.arabic;
      break;
    case "en":
      return Translate.english;
      break;
    case "pa":
      return Translate.kurdish;
      break;
    case "tr":
      return Translate.kurdish;
      break;
    default:
      return Translate.kurdish;
  }
}

import 'package:testgsschoolst/localization/local_keys.dart';

String validatePassword(String value) {
  if (value.isEmpty || value.trim().isEmpty) {
    return Translate.requarid.trans();
  } else if (value.trim().length < 4) {
    return Translate.requarid.trans();
  }
  return null;
}

String validateRePassword(String value, String password) {
  if (value.isEmpty || value.trim().isEmpty) {
    return Translate.requarid.trans();
  } else if (value.trim().length < 6) {
    return Translate.requarid.trans();
  } else if (value != password) {
    return Translate.requarid.trans();
  }
  return null;
}

String validateNote(String value) {
  if (value.trim().isEmpty) {
    return Translate.requarid.trans();
  }

  if (value.length < 1) {
    return Translate.requarid.trans();
  } else {
    return null;
  }
}

String validateName(String value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Translate.requarid.trans();
  }
  return null;
}

String validatePrice(String value) {
  if (value == null || value.trim().isEmpty || value.isEmpty) {
    return Translate.requarid.trans();
  }
  return null;
}

String withoutValidate(String value) {
  return null;
}

String nullAbleFileds(String value) {
  if (value.trim().isEmpty) {
    return null;
  } else {
    return null;
  }
}

String validatephoneNullAble(String value) {
  Pattern pattern = '^07[3-9][0-9][0-9]{7}\$';
  RegExp regex = new RegExp(pattern);
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  if (!regex.hasMatch(value)) {
    return "07XX XXX XXXX";
  } else {
    return null;
  }
}

String validatephone(String value) {
  Pattern pattern = '^07[3-9][0-9][0-9]{7}\$';
  RegExp regex = new RegExp(pattern);
  if (value == null || value.trim().isEmpty) {
    return Translate.requarid.trans();
  }
  if (!regex.hasMatch(value)) {
    return "07XX XXX XXXX";
  } else {
    return null;
  }
}

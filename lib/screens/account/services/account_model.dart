// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

import 'package:testgsschoolst/repo/constant.dart';

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.id,
    this.token,
    this.userName,
    this.password,
    this.firstName,
    this.image,
    this.middleName,
    this.lastName,
    this.userType,
    this.phone,
    this.isPrimary,
    this.isSelected,
    this.refreshToken,
  });

  String id;
  String token;
  String userName;
  String password;
  String firstName;
  String image;
  String middleName;
  String lastName;
  String userType;
  String phone;
  bool isPrimary;
  bool isSelected;
  String refreshToken;

  factory AccountModel.fromJson(Map<String, dynamic> json, bool isFromDB) =>
      AccountModel(
        id: json["id"],
        token: json["token"],
        userName: json["userName"],
        password: json["password"],
        firstName: json["firstName"],
        isPrimary:
            isFromDB == false ? json["isPrimary"] : json["isPrimary"] == 1,
        image: json["image"].toString().contains("http")
            ? json["image"].replaceAll("comuploads", "com\/uploads")
            : json["image"] != null && json["image"] != ""
                ? "$URL\/" + json["image"].toString().replaceAll("\\", "\/")
                : null,
        middleName: json["middleName"],
        lastName: json["lastName"],
        userType: json["userType"],
        phone: json["phone"],
        isSelected: json["isSelected"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "userName": userName,
        "password": password,
        "firstName": firstName,
        "image": image,
        "middleName": middleName,
        "lastName": lastName,
        "userType": userType,
        "phone": phone,
        "isPrimary": isPrimary,
        "isSelected": isSelected,
        "refreshToken": refreshToken,
      };
}

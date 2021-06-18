// To parse this JSON data, do
//
//     final chatPersonsModel = chatPersonsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';



String chatPersonsModelToJson(Messages data) =>
    json.encode(data.toJson());

class Messages {
  Messages(
      {this.id,
      this.firstName,
      this.lastName,
      this.lastConversationTime,
      this.lastMessageText,
      this.picPath,
      this.userRole,
      this.targetId,
      this.gradeId,
      this.forUser,
      this.messageStatus});

  int id;
  String firstName;
  String lastName;
  String lastConversationTime;
  String lastMessageText;
  String picPath;
  String userRole;
  String targetId;
  String gradeId;
  String forUser;
  MessageStatus messageStatus;
  factory Messages.fromJson(Map<String, dynamic> json , MessageStatus status) =>
      Messages(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        lastConversationTime: json["lastConversationTime"] == null
            ? ''
            : Jiffy(json["lastConversationTime"]).yMMMEdjm,
        lastMessageText: json["lastMessageText"],
        picPath: json["picPath"].toString().contains("http")
            ? json["picPath"]
            : json["picPath"] != null && json["picPath"] != ""
                ? "$URL\/" + json["picPath"].toString().replaceAll("\\", "\/")
                : null,
        userRole: json["userRole"],
        targetId: json["targetId"],
        gradeId: json["gradeId"],
        forUser: json["forUser"],
        messageStatus:status

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "lastConversationTime": lastConversationTime,
        "lastMessageText": lastMessageText,
        "picPath": picPath,
        "userRole": userRole,
        "targetId": targetId,
        "gradeId": gradeId,
        "forUser": forUser,
      };
}

class ChatPersonsModelResponse {
  List<Messages> data;
  Status status;
  ChatPersonsModelResponse({
    @required this.data,
    @required this.status,
  });
}

enum MessageStatus { sending, error, sent }

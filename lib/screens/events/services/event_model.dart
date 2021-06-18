// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.eventTitle,
    this.schoolName,
    this.description,
    this.startDate,
    this.endDate,
    this.isHoliday,
    this.hasAttachment,
    this.attachment,
    this.id,
  });

  String eventTitle;
  int schoolName;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool isHoliday;
  bool hasAttachment;
  String attachment;
  int id;

  factory EventModel.fromJson(Map<String, dynamic> json, bool isFromDb) =>
      EventModel(
        eventTitle: json["eventTitle"],
        schoolName: json["schoolName"],
        description: json["description"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        isHoliday: json["isHoliday"] == "1" ||
                json["isHoliday"] == 1 ||
                json["isHoliday"] == true
            ? true
            : false,
        hasAttachment: json["hasAttachment"] == "1" ||
                json["hasAttachment"] == 1 ||
                json["hasAttachment"] == true
            ? true
            : false,
        attachment: json["attachment"].toString().contains("http")
            ? json["attachment"].replaceAll("comuploads", "com\/uploads")
            : json["attachment"] != null && json["attachment"] != ""
                ? "$URL\/" +
                    json["attachment"].toString().replaceAll("\\", "\/")
                : null,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "eventTitle": eventTitle,
        "schoolName": schoolName,
        "description": description,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "isHoliday": isHoliday,
        "hasAttachment": hasAttachment,
        "attachment": attachment,
        "id": id,
      };
}

class EventModelResponse {
  List<EventModel> data;
  Status status;
  EventModelResponse({
    @required this.status,
    @required this.data,
  });
}

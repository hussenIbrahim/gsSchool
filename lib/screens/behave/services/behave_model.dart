// To parse this JSON data, do
//
//     final behaveModel = behaveModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testgsschoolst/repo/enums.dart';

String behaveModelToJson(BehaveModel data) => json.encode(data.toJson());

class BehaveModel {
  BehaveModel({
    this.id,
    this.date,
    this.behaveType,
    this.note,
    this.schoolName,
    this.subjectName,
    this.studentId,
  });

  int id;
  String date;
  int behaveType;
  String note;
  int schoolName;
  String subjectName;
  int studentId;

  factory BehaveModel.fromJson(Map<String, dynamic> json, bool isFromDB) =>
      BehaveModel(
        id: json["id"],
        date: Jiffy(json["date"]).yMMMEdjm,
        behaveType: json["behaveType"],
        note: json["note"],
        schoolName: json["schoolName"],
        subjectName: json["subjectName"],
        studentId: json["studentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "behaveType": behaveType,
        "note": note,
        "schoolName": schoolName,
        "subjectName": subjectName,
        "studentId": studentId,
      };
}

class BehaveModelResponse {
  List<BehaveModel> data;
  Status status;
  BehaveModelResponse({
    @required this.status,
    @required this.data,
  });
}

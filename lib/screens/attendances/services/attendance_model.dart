// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testgsschoolst/repo/enums.dart';

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  AttendanceModel({
    this.id,
    this.studentId,
    this.date,
    this.attendanceType,
    this.remark,
    this.schoolName,
    this.isActive,
    this.subjectName,
  });

  int id;
  int studentId;
  String date;
  int attendanceType;
  dynamic remark;
  int schoolName;
  bool isActive;

  String subjectName;

  factory AttendanceModel.fromJson(Map<String, dynamic> json, bool isFromDb) =>
      AttendanceModel(
        id: json["id"],
        studentId: json["studentId"],
        date: Jiffy(json["date"]).yMMMEdjm,
        attendanceType: json["attendanceType"],
        remark: json["remark"],
        schoolName: json["schoolName"],
        isActive: json["isActive"],
        subjectName: json["subjectName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "date": DateUtils,
        "attendanceType": attendanceType,
        "remark": remark,
        "schoolName": schoolName,
        "isActive": isActive,
        "subjectName": subjectName,
      };
}

class AttendanceModelResponse {
  List<AttendanceModel> data;
  Status status;
  AttendanceModelResponse({
    @required this.status,
    @required this.data,
  });
}

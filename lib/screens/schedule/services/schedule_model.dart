import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/repo/enums.dart';

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    this.id,
    this.lessonNo,
    this.subjectName,
    this.className,
    this.teacherName,
    this.dayName,
    this.startTime,
    this.studentId,
    this.durationInMinutes,
    this.classId,
    this.subjectId,
  });

  int id;
  int lessonNo;
  String subjectName;
  String className;
  String teacherName;
  String dayName;
  dynamic startTime;
  String studentId;
  int durationInMinutes;
  int classId;
  String subjectId;

  factory ScheduleModel.fromJson(Map<String, dynamic> json, bool isFromDb) =>
      ScheduleModel(
        id: json["id"],
        lessonNo: json["lessonNo"],
        subjectName: json["subjectName"],
        className: json["className"],
        teacherName: json["teacherName"],
        dayName: json["dayName"],
        startTime: json["startTime"],
        studentId: json["studentId"],
        durationInMinutes: json["durationInMinutes"],
        classId: json["classId"],
        subjectId: json["subjectId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lessonNo": lessonNo,
        "subjectName": subjectName,
        "className": className,
        "teacherName": teacherName,
        "dayName": dayName,
        "startTime": startTime,
        "studentId": studentId,
        "durationInMinutes": durationInMinutes,
        "classId": classId,
        "subjectId": subjectId,
      };
}

class ScheduleModellResponse {
  List<ScheduleModel> data;
  Status status;
  ScheduleModellResponse({
    @required this.status,
    @required this.data,
  });
}

// To parse this JSON data, do
//
//     final examesModel = examesModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/repo/enums.dart';

ExamesModel examesModelFromJson(String str) =>
    ExamesModel.fromJson(json.decode(str));

String examesModelToJson(ExamesModel data) => json.encode(data.toJson());

class ExamesModel {
  ExamesModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.addedBy,
    this.examTitle,
    this.description,
    this.teacherName,
    this.dateOfExam,
    this.fullMarks,
    this.passingMarks,
    this.note,
    this.schoolName,
    this.subject,
    this.subjectId,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;
  String addedBy;
  String examTitle;
  String description;
  String teacherName;
  DateTime dateOfExam;
  int fullMarks;
  int passingMarks;
  String note;
  int schoolName;
  Subject subject;
  int subjectId;

  factory ExamesModel.fromJson(Map<String, dynamic> json) => ExamesModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isActive: json["isActive"],
        addedBy: json["addedBy"],
        examTitle: json["examTitle"],
        description: json["description"],
        teacherName: json["teacherName"],
        dateOfExam: DateTime.parse(json["dateOfExam"]),
        fullMarks: json["fullMarks"],
        passingMarks: json["passingMarks"],
        note: json["note"],
        schoolName: json["schoolName"],
        subject: Subject.fromJson(json["subject"]),
        subjectId: json["subjectId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "isActive": isActive,
        "addedBy": addedBy,
        "examTitle": examTitle,
        "description": description,
        "teacherName": teacherName,
        "dateOfExam": dateOfExam.toIso8601String(),
        "fullMarks": fullMarks,
        "passingMarks": passingMarks,
        "note": note,
        "schoolName": schoolName,
        "subject": subject.toJson(),
        "subjectId": subjectId,
      };
}

class Subject {
  Subject({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.addedBy,
    this.code,
    this.name,
    this.order,
    this.schoolName,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;
  String addedBy;
  String code;
  String name;
  int order;
  int schoolName;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isActive: json["isActive"],
        addedBy: json["addedBy"],
        code: json["code"],
        name: json["name"],
        order: json["order"],
        schoolName: json["schoolName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "isActive": isActive,
        "addedBy": addedBy,
        "code": code,
        "name": name,
        "order": order,
        "schoolName": schoolName,
      };
}

class ExamesModelResponse {
  List<ExamesModel> data;
  Status status;
  ExamesModelResponse({
    @required this.status,
    @required this.data,
  });
}

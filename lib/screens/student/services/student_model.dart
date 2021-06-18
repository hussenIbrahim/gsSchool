import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));
String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.id,
    this.firstName,
    this.dob,
    this.isMale,
    this.note,
    this.graduated,
    this.attachment,
    this.gradeId,
    this.gradeName,
    this.parentId,
    this.fatherName,
    this.grandFatherName,
  });

  String id;
  String firstName;
  DateTime dob;
  bool isMale;
  String note;
  bool graduated;
  String attachment;
  int gradeId;
  String gradeName;
  int parentId;
  String fatherName;
  String grandFatherName;

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json["id"],
      firstName: json["firstName"],
      dob: DateTime.parse(json["dob"] ?? DateTime.now().toIso8601String()),
      isMale: json["isMale"] == true ||
              json["isMale"] == "1" ||
              json["isMale"] == "true"
          ? true
          : false,
      note: json["note"],
      graduated: json["graduated"],
      attachment: json["attachment"].toString().contains("http")
          ? json["attachment"].replaceAll("comuploads", "com\/uploads")
          : json["attachment"] != null && json["attachment"] != ""
              ? "$URL\/" + json["attachment"].toString().replaceAll("\\", "\/")
              : null,
      gradeId: json["gradeId"],
      gradeName: json["gradeName"],
      parentId: json["parentId"],
      fatherName: json["fatherName"],
      grandFatherName: json["grandFatherName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "dob": dob.toIso8601String(),
        "isMale": isMale,
        "note": note,
        "graduated": graduated,
        "attachment": attachment,
        "gradeId": gradeId,
        "gradeName": gradeName,
        "parentId": parentId,
        "fatherName": fatherName,
        "grandFatherName": grandFatherName,
      };
}

class StudentRequest {
  List<StudentModel> data;
  Status status;
  StudentRequest({
    @required this.data,
    @required this.status,
  });
}

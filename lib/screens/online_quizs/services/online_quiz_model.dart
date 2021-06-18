import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/repo/enums.dart';

String subjectModelToJson(OnLineQuizModel data) => json.encode(data.toJson());

class OnLineQuizModel {
  OnLineQuizModel({
    this.id,
    this.code,
    this.name,
    this.order,
    this.schoolName,
    this.studentId,
    this.image,
  });

  int id;
  String code;
  String name;
  int schoolName;
  String studentId;
  int order;
  String image;

  factory OnLineQuizModel.fromJson(Map<String, dynamic> json, bool isFromDB) =>
      OnLineQuizModel(
        id: json["id"],
        code: json["code"],
        order: isFromDB == true ? json['subjectOrder'] : json["order"],
        name: json["name"],
        image: json["image"],
        studentId: json["studentId"],
        schoolName: json["schoolName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subjectOrder": order,
        "code": code,
        "image": image,
        "name": name,
        "studentId": studentId,
        "schoolName": schoolName,
      };
}

class OnLineQuizModelResponse {
  List<OnLineQuizModel> data;
  Status status;
  OnLineQuizModelResponse({
    @required this.status,
    @required this.data,
  });
}

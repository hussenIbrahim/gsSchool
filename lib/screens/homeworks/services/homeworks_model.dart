import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testgsschoolst/repo/enums.dart';

String homeWorksModelToJson(HomeWorksModel data) => json.encode(data.toJson());

class HomeWorksModel {
  HomeWorksModel(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.pdf,
      this.dueTo,
      this.hasAttachment,
      this.hasEquation,
      this.staffName,
      this.subjectName,
      this.isAnswerAccepted,
      this.studentId,
      this.isSubmittedAnswer,
      this.hasPdf});

  int id;
  String title;
  String description;
  String image;
  String pdf;
  String dueTo;
  bool hasAttachment;
  bool hasEquation;
  String staffName;
  String subjectName;
  bool isAnswerAccepted;
  String studentId;
  bool isSubmittedAnswer;
  bool hasPdf;
  factory HomeWorksModel.fromJson(Map<String, dynamic> json, bool isFromDB) =>
      HomeWorksModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        hasPdf: json["hasPdf"],
        image: json["image"],
        studentId: json["studentId"],
        pdf: json["pdf"],
        dueTo: Jiffy(json["dueTo"]).yMMMEdjm,
        hasAttachment: json["hasAttachment"],
        hasEquation: json["hasEquation"],
        staffName: json["staffName"],
        subjectName: json["subjectName"],
        isAnswerAccepted: json["isAnswerAccepted"],
        isSubmittedAnswer: json["isSubmittedAnswer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "hasPdf": hasPdf,
        "studentId": studentId,
        "image": image,
        "pdf": pdf,
        "dueTo": dueTo,
        "hasAttachment": hasAttachment,
        "hasEquation": hasEquation,
        "staffName": staffName,
        "subjectName": subjectName,
        "isAnswerAccepted": isAnswerAccepted,
        "isSubmittedAnswer": isSubmittedAnswer,
      };
}

class HomeWorksModellResponse {
  List<HomeWorksModel> data;
  Status status;
  HomeWorksModellResponse({
    @required this.status,
    @required this.data,
  });
}

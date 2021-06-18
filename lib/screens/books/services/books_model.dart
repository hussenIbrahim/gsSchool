import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';

BooksModel booksModelFromJson(String str) =>
    BooksModel.fromJson(json.decode(str));

String booksModelToJson(BooksModel data) => json.encode(data.toJson());

class BooksModel {
  BooksModel({
    this.id,
    this.title,
    this.note,
    this.coverLink,
    this.sizeInMb,
    this.downloadLink,
    this.savedName,
    
    this.subjectId,
  
    this.schoolName,
    this.subjectCode,
    this.studentId,
    this.subjectName,
  });

  int id;
  String title;
  dynamic note;
  String coverLink;
  String sizeInMb;
  String downloadLink;
  String savedName;
   int subjectId;
 
  int schoolName;
  String subjectCode;
  String subjectName;
  String studentId;

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        sizeInMb: json["sizeInMb"],
        downloadLink: json["downloadLink"].toString().contains("http")
            ? json["downloadLink"]
            : json["downloadLink"] != null && json["downloadLink"] != ""
                ? "$URL\/" +
                    json["downloadLink"].toString().replaceAll("\\", "\/")
                : null,
        coverLink: json["coverLink"].toString().contains("http")
            ? json["coverLink"]
            : json["coverLink"] != null && json["coverLink"] != ""
                ? "$URL\/" + json["coverLink"].toString().replaceAll("\\", "\/")
                : null,
        savedName: json["savedName"],
         subjectId: json["subjectId"],
        
        schoolName: json["schoolName"],
        subjectCode: json["subjectCode"],
        subjectName: json["subjectName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "coverLink": coverLink,
        "sizeInMb": sizeInMb,
        "downloadLink": downloadLink,
        "studentId": studentId,
        "savedName": savedName,
        "subjectId": subjectId,
      
        "schoolName": schoolName,
        "subjectCode": subjectCode,
        "subjectName": subjectName,
      };
}

class BooksModelResponse {
  List<BooksModel> data;
  Status status;
  BooksModelResponse({
    @required this.status,
    @required this.data,
  });
}

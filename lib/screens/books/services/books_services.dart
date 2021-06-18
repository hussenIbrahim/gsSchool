import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/books/services/books_model.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';
import 'package:testgsschoolst/widget/alerts/show_toast.dart';

// ReceivePort _port = ReceivePort();

// downloadCallback(String id, DownloadTaskStatus status, int progress) {
//   myPrint(
//       'Background Iso Callback: task ($id) is in status ($status) and process ($progress)');

//   final SendPort send =
//       IsolateNameServer.lookupPortByName('downloader_send_port');
//   send.send([id, status, progress]);
// }

class BooksServices {
  // BooksServices() {
  //   IsolateNameServer.registerPortWithName(
  //       _port.sendPort, 'downloader_send_port');
  //   _port.listen((dynamic data) {
  //     String id = data[0];
  //     myPrint("id $id");
  //     DownloadTaskStatus status = data[1];
  //     myPrint("status $status");
  //     int progress = data[2];
  //     myPrint("progress $progress");
  //   });

  //   FlutterDownloader.registerCallback(downloadCallback);
  // }
  Future<BooksModelResponse> _getBooks(int page, String day) async {
    // try {
      myPrint(connectionNotifer.isConnected);
      final url =
          "$URL/api/CourseBooks?_start=0&_end=1000";

      myPrint(url);
      http.Response customer = await http
          .get(Uri.parse(url), headers: getAppHeader())
          .timeout(DURATION_60);

      myPrint("Evetns ${customer.statusCode}");
      myPrint("Evetns ${customer.body}");
      if (customer.statusCode == 200) {
        BooksModelResponse result =
            await compute(parseCustomerPayments, customer.body);

        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return BooksModelResponse(status: Status.error, data: []);
    // } catch (e) {
    //   myPrint("error in get Evetns sv $e");
    //   if (e.toString().contains("TimeoutException") ||
    //       e.toString().contains("No address associated with hostname")) {
    //     return BooksModelResponse(status: Status.newtworkError, data: []);
    //   }
    //   return BooksModelResponse(status: Status.error, data: []);
    // }
  }

  ///Here based on forceGet ethier get data from local or remote
  Future<BooksModelResponse> getBooksMiddleWare(
      bool forceGet, int subjectId, String studentId) async {
    BooksModelResponse booksModelResponse =
        BooksModelResponse(data: <BooksModel>[], status: Status.noDataFound);
    booksModelResponse = await _readFromLocalDatabase(
        studentId: studentId, subjectId: subjectId);
    bool fromApi = forceGet == true ||
        booksModelResponse.data.length == 0 ||
        booksModelResponse.status == Status.noDataFound;
    if (fromApi) {
      BooksModelResponse result = await _getBooks(0, studentId);
      for (var j = 0; j < result.data.length; j++) {
        for (var i = 0; i < booksModelResponse.data.length; i++) {
          if (result.data[j].id == booksModelResponse.data[i].id) {
            result.data[j].savedName = booksModelResponse.data[i].savedName;
          }
        }
      }
      _saveEventToLoca(result.data);
      return result;
    } else {
      return booksModelResponse;
    }
  }

  _saveEventToLoca(List<BooksModel> list) async {
    final _db = await database;
    list.forEach((model) {
      try {
        _db.insert(BooksTable, model.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        myPrint("error im save SubjectSchedule to local $e");
      }
    });
  }

  Future<BooksModelResponse> _readFromLocalDatabase(
      {int subjectId, String studentId}) async {
    List<BooksModel> list = [];
    // try {
      final _db = await database;
      myPrint( 'subjectId ${subjectId == 0 ? '!=' : '='}? AND studentId =?');
      final List<Map<dynamic, dynamic>> data = await _db.query(BooksTable,
          where: 'subjectId ${subjectId == 0 ? '!=' : '='}? AND studentId =?',
          whereArgs: [subjectId, studentId]);

      myPrint("mapmapmap  $data $subjectId");
      if (data.isEmpty) {
        return BooksModelResponse(data: list, status: Status.noDataFound);
      }
      data.forEach((key) {
        BooksModel temp = BooksModel.fromJson(Map<String, dynamic>.from(key));
        list.add(temp);
      });
      return BooksModelResponse(data: list, status: Status.dataFound);
    // } catch (e) {
    //   myPrint("error in read events from database$e");
    //   return BooksModelResponse(data: list, status: Status.error);
    // }
  }

  Future<void> deleteFile(BooksModel model) async {
    try {
      await File(model.savedName).delete();
      myPrint("File was deleted");
      booksNotifer.upDateBooks(model..savedName = null);
      _saveEventToLoca([model..savedName = null]);
    } catch (e) {
      if (e
          .toString()
          .toUpperCase()
          .contains("No such file or directory".toUpperCase())) {
        _saveEventToLoca([model..savedName = null]);

        booksNotifer.upDateBooks(model..savedName = null);
      }
      myPrint("falied dlete file $e");
    }
  }

  Future<void> downloadFile(BooksModel model) async {
    String savePath = await _getFilePath("/" + model.title + ".pdf");
    myPrint("savePath $savePath");
    Dio.Dio dio = Dio.Dio();
    try {
      final res = await dio.download(model.downloadLink, savePath);
      myPrint("res ${res.statusCode} ${res.data}");
      if (res.statusCode == 200) {
        _saveEventToLoca([model..savedName = savePath]);
        booksNotifer.upDateBooks(model..savedName = savePath);
      }
      myPrint("res $res");
    } catch (e) {
      showToast("failed to download books");
      myPrint("error in download files $e");
    }
  }
  // Future<void> downloadFile(uri, fileName) async {
  //   String savePath = await _getFilePath(fileName);
  //   myPrint("savePath $savePath");
  //   try {
  //     final taskId = await FlutterDownloader.enqueue(
  //       url: uri,
  //       savedDir: savePath,
  //       showNotification:
  //           true, // show download progress in status bar (for Android)
  //       openFileFromNotification:
  //           true, // click on notification to open downloaded file (for Android)
  //     );
  //     myPrint("taskId $taskId");
  //   } catch (e) {
  //     myPrint("error in download files $e");
  //   }
  // }

  //gets the applicationDirectory and path for the to-be downloaded file

  // which will be used to save the file to that path in the downloadFile method

  Future<String> _getFilePath(uniqueFileName) async {
    String _localPath = (await _findLocalPath());

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (hasExisted) {
      await savedDir.create();
    }

    return savedDir.path + uniqueFileName;
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await (getApplicationDocumentsDirectory())
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

BooksModelResponse parseCustomerPayments(String responseBody) {
  myPrint(responseBody);
  List<BooksModel> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    BooksModel documentsCostumers = BooksModel.fromJson({
      ...body[i],
      ...body[i]['subject'],
     });
    documentsCostumers.studentId = "";
    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get BooksModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return BooksModelResponse(status: Status.noDataFound, data: list);
  }
  return BooksModelResponse(status: Status.dataFound, data: list);
}

import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/books/services/books_model.dart';
import 'package:testgsschoolst/screens/books/services/books_services.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';

import '../../../locator.dart';

class BooksNotifer extends ChangeNotifier {
  Status getDataStatus = Status.initState;
  List<BooksModel> eventsList = [];
  final services = locator<BooksServices>();

  SubjectModel subjectModel;
  List<SubjectModel> subjects = [];
  setSubjects(List<SubjectModel> _subjects) {
    subjects = _subjects;
    notifyListeners();
  }

  changeSubjectModel(SubjectModel newYear) {
    subjectModel = newYear;
    notifyListeners();
    refresh(false);
  }

  upDateBooks(BooksModel model) {
    eventsList[eventsList.indexWhere((element) => element.id == model.id)] =
        model;
    notifyListeners();
  }

  getBooks(bool forceRefesh, int day) async {
    BooksModelResponse data =
        await services.getBooksMiddleWare(forceRefesh, day, getUserId());
    getDataStatus = data.status;
    myPrint("BooksModelResponse data  $data");

    if (getDataStatus == Status.dataFound) {
      final List<BooksModel> _productModelList = data.data;

      eventsList.addAll(_productModelList);
    }

    final _ids = eventsList.map((e) => e.id).toSet();
    eventsList.retainWhere((x) => _ids.remove(x.id));

    notifyListeners();
  }

  refresh(bool force) {
    getDataStatus = Status.loading;
    eventsList = [];
    notifyListeners();
    getBooks(force, subjectModel?.id ?? 0);
  }
}

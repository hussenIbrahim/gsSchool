
import 'package:flutter/material.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/exames/services/exames_mode.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_model.dart';

class ScheduleTodayModelResponse {
  List<ScheduleModel>schedules;
  List<HomeWorksModel>homeworks;
  List<ExamesModel>exames;
  Status status;
  ScheduleTodayModelResponse({
    @required this.status,
    @required this.schedules,
    @required this.homeworks,
    @required this.exames,
  });
}

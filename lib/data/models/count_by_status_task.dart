import 'package:project_task_manager/data/models/task_by_status_data.dart';

class CountByStatusTask {
  String? status;
  List<TaskByStatusData>? listOfTaskByStatusData;

  CountByStatusTask({this.status, this.listOfTaskByStatusData});

  CountByStatusTask.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskByStatusData = <TaskByStatusData>[];
      json['data'].forEach((v) {
        listOfTaskByStatusData!.add(TaskByStatusData.fromJson(v));
      });
    }
  }
}

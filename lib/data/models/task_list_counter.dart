import 'package:project_task_manager/data/models/task_counter_item.dart';

class TaskListCounter {
  String? status;
  List<TaskCounterItem>? taskList;

  TaskListCounter({this.status, this.taskList});

  TaskListCounter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskCounterItem>[];
      json['data'].forEach((v) {
        taskList!.add(TaskCounterItem.fromJson(v));
      });
    }
  }
}

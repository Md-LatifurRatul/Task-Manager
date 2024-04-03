import 'package:get/get.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class CompletedTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  TaskListCounter _completedTaskListCounter = TaskListCounter();

  String get errorMessage =>
      _errorMessage ?? "Get completed task list has been has been failed";
  TaskListCounter get completedTaskListCounter => _completedTaskListCounter;

  Future<bool> getCancelledTaskController() async {
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.completedTaskList);

    _inProgress = false;
    if (response.isSucess) {
      _completedTaskListCounter =
          TaskListCounter.fromJson(response.responseBody);
      update();
      return true;
    } else {
      _inProgress = false;
      update();
      _errorMessage = response.errorMessage;
      return false;
    }
  }
}

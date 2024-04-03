import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class ProgressTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  TaskListCounter _progressTaskListCounter = TaskListCounter();

  String get errorMessage =>
      _errorMessage ?? "Get Progress task list has been failed";
  TaskListCounter get progressTaskListCounter => _progressTaskListCounter;

  Future<bool> getProgressTaskController() async {
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.progressTaskList);

    _inProgress = false;
    if (response.isSucess) {
      _progressTaskListCounter =
          TaskListCounter.fromJson(response.responseBody);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _inProgress = false;
      update();
      return false;
    }
  }
}

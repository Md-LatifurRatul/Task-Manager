import 'package:get/get.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class NewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  TaskListCounter _newTaskListCounter = TaskListCounter();

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Get new task list has been has been failed';

  TaskListCounter get taskListCounter => _newTaskListCounter;

  Future<bool> getNewTaskController() async {
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.newlistTaskByStatus);
    _inProgress = false;

    if (response.isSucess) {
      _newTaskListCounter = TaskListCounter.fromJson(response.responseBody);
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

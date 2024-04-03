import 'package:get/get.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class CancelledTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  TaskListCounter _cancelledTaskList = TaskListCounter();
  String get errorMessage =>
      _errorMessage ?? "Cancelled task list has been failed";
  TaskListCounter get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCancelledTaskController() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final reponse = await NetworkCaller.getRequest(Urls.cancellTaskList);
    _inProgress = false;
    if (reponse.isSucess) {
      _cancelledTaskList = TaskListCounter.fromJson(reponse.responseBody);
      isSuccess = true;
    } else {
      _errorMessage = reponse.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}

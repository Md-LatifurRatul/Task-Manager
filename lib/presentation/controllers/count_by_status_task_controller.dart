import 'package:get/get.dart';
import 'package:project_task_manager/data/models/count_by_status_task.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class CountByStatusTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  CountByStatusTask _countByStatusTask = CountByStatusTask();

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Get Task count by status has been failed';

  CountByStatusTask get countByStatusTask => _countByStatusTask;

  Future<bool> getCountByStatusTask() async {
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.taskStatusCount);

    _inProgress = false;

    if (response.isSucess) {
      _countByStatusTask = CountByStatusTask.fromJson(response.responseBody);

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

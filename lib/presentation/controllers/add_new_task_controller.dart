import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/data/models/response_object.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  bool _shouldRefreshBackToNewTaskList = false;

  bool get inProgress => _inProgress;

  bool get shouldRefreshBackToNewTaskList => _shouldRefreshBackToNewTaskList;

  Future<bool> getAddNewTaskController(TextEditingController title,
      TextEditingController description, String newStatus) async {
    _inProgress = true;
    bool isSuccess = false;

    update();

    Map<String, dynamic> inputParams = {
      "title": title.text.trim(),
      "description": description.text.trim(),
      "status": newStatus
    };

    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);
    _inProgress = false;

    if (response.isSucess) {
      _shouldRefreshBackToNewTaskList = true;
      title.clear();
      description.clear();
      isSuccess = true;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class DeleteTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Delete task has been failed';

  Future<bool> getDeleteTaskController(
      String id, VoidCallback refreshList) async {
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.deleteTaskById(id));
    _inProgress = false;

    if (response.isSucess) {
      update();
      refreshList();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _inProgress = false;
      update();

      return false;
    }
  }
}

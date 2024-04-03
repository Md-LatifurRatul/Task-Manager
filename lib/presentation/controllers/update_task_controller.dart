import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class UpdateTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? "Update task status has been has been failed";

  Future<bool> getUpdateTaskController(
      String id, String status, VoidCallback refreshList) async {
    _inProgress = true;
    update();

    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _inProgress = false;

    if (response.isSucess) {
      refreshList();
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

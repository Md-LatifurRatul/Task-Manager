import 'dart:developer';
import 'package:get/get.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';

class VerifyEmailController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Failed to send the email';

  Future<bool> getVerifyEmailController(String email) async {
    String saveEmail = email;

    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.verifyEmail(email));

    _inProgress = false;
    if (response.isSucess) {
      await AuthController.saveVerifyEmail(saveEmail);
      log(AuthController.verifyEmail.toString());
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

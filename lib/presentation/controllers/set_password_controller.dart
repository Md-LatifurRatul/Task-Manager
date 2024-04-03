import 'package:get/get.dart';
import 'package:project_task_manager/data/models/recover_reset_password.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';

class SetPasswordController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Password updated failed! Try again';

  Future<bool> getPasswordController(String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": AuthController.verifyEmail,
      "OTP": AuthController.verifyOtp,
      "password": password,
    };

    final response =
        await NetworkCaller.postRequest(Urls.recoverResetPassword, inputParams);
    _inProgress = false;

    if (response.isSucess) {
      RecoveryResetPassword recoveryResetPassword =
          RecoveryResetPassword.fromJson(response.responseBody);

      print(recoveryResetPassword.password);
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

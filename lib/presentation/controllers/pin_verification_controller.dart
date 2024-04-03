import 'package:get/get.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';

class PinVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? "Pin verification falided! Try again";

  Future<bool> getPinVerificationController(String otp) async {
    String saveOtp = otp;
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(
        Urls.verifyOtp(AuthController.verifyEmail!, otp));
    _inProgress = false;

    if (response.isSucess) {
      await AuthController.saveVerifyOtp(saveOtp);
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

import 'package:get/get.dart';
import 'package:project_task_manager/data/models/login_response.dart';
import 'package:project_task_manager/data/models/response_object.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgres => _inProgress;
  String get errorMessage => _errorMessage ?? 'Login Failed Try again';

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "password": password,
    };

    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.loginUrl, inputParams,
        fromSignIn: true);
    _inProgress = false;

    if (response.isSucess) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);
      // print(loginResponse.userData?.firstName);

      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);

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

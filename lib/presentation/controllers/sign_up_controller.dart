import 'package:get/get.dart';
import 'package:project_task_manager/data/models/response_object.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  Future<bool> signUp(String email, String firstName, String lastName,
      String mobileNumber, String password) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobileNumber,
      "password": password,
    };
    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.registrationUrl, inputParams);

    if (response.isSucess) {
      isSuccess = true;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_task_manager/data/models/user_data.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';

class ProfileUpdateController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMessage;
  String get errorMessage =>
      _errorMessage ?? 'Update Profile failed! Try again';

  Future<bool> getUpdateProfileController(
      String email,
      String firstName,
      String lastName,
      String mobileNumber,
      String password,
      XFile? imagePicked) async {
    String? photo;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobileNumber,
    };

    if (password.isNotEmpty) {
      inputParams["password"] = password;
    }

    if (imagePicked != null) {
      List<int> bytes = File(imagePicked.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams["photo"] = photo;
    }
    final response =
        await NetworkCaller.postRequest(Urls.updateProfileUrl, inputParams);

    if (response.isSucess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobileNumber,
        );

        await AuthController.saveUserData(userData);
      }
      _inProgress = false;
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

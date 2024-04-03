import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart' as get_x;
import 'package:http/http.dart' as http;
import 'package:project_task_manager/data/models/response_object.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';
import 'package:project_task_manager/presentation/screens/auth/sign_in_screen.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      log(url);
      log(AuthController.accessToken.toString());

      final http.Response response = await http.get(Uri.parse(url),
          headers: {'token': AuthController.accessToken ?? ''});
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSucess: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        _moveToSignIn();

        return ResponseObject(
          isSucess: false,
          statusCode: response.statusCode,
          responseBody: '',
        );
      } else {
        return ResponseObject(
          isSucess: false,
          statusCode: response.statusCode,
          responseBody: '',
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSucess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body,
      {bool fromSignIn = false}) async {
    try {
      log(url);
      log(body.toString());
      final http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? ''
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSucess: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        if (fromSignIn) {
          return ResponseObject(
              isSucess: false,
              statusCode: response.statusCode,
              responseBody: '',
              errorMessage: 'Email/password is incorrect! Try again.');
        } else {
          _moveToSignIn();
          return ResponseObject(
            isSucess: false,
            statusCode: response.statusCode,
            responseBody: '',
          );
        }
      } else {
        return ResponseObject(
            isSucess: false, statusCode: response.statusCode, responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSucess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }

  static Future<void> _moveToSignIn() async {
    await AuthController.clearUserData();

    get_x.Get.offUntil(
        get_x.GetPageRoute(page: () => const SignInScreen()), (route) => false);
  }
}

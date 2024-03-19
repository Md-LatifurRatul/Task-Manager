import 'dart:convert';
import 'package:project_task_manager/data/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? accessToken;
  static String? verifyEmail;
  static UserData? userData;
  static String? verifyOtp;

  static Future<void> saveUserData(UserData userData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'userData', jsonEncode(userData.toJson()));
    AuthController.userData = userData;
  }

  static Future<UserData?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString('userData');
    if (result == null) {
      return null;
    }

    final user = UserData.fromJson(jsonDecode(result));
    AuthController.userData = user;
    return user;
  }

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    accessToken = token;
  }

  static Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static Future<bool> isUserLoggedIn() async {
    final result = await getUserToken();
    accessToken = result;
    bool loginState = result != null;
    if (loginState) {
      await getUserData();
    }
    return loginState;
  }

  static Future<void> saveVerifyEmail(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('verifyEmail', email);
    verifyEmail = email;
  }

  static Future<String?> getVerifyEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('verifyEmail');
  }

  static Future<void> saveVerifyOtp(String otp) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('verifyOtp', otp);
    verifyOtp = otp;
  }

  static Future<String?> getVerifyOtp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('verifyOtp');
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}

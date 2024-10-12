import 'package:project_task_manager/data/models/user_data.dart';

class LoginResponse {
  String? status;
  String? token;
  List<UserData>? userData;

  LoginResponse({this.status, this.token, this.userData});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      userData = <UserData>[];

      json['data'].forEach(
        (userJson) {
          userData!.add(UserData.fromJson(userJson));
        },
      );
    }
    token = json['token'];
  }
}

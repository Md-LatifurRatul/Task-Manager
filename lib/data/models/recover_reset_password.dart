class RecoveryResetPassword {
  String? email;
  String? oTP;
  String? password;

  RecoveryResetPassword({this.email, this.oTP, this.password});

  RecoveryResetPassword.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    oTP = json['OTP'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['OTP'] = oTP;
    data['password'] = password;
    return data;
  }
}

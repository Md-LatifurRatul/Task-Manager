class UserData {
  String? sId;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? password;
  String? createdDate;
  String? photo;

  UserData(
      {this.sId,
      this.email,
      this.firstName,
      this.lastName,
      this.mobile,
      this.password,
      this.createdDate,
      this.photo});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    password = json['password'];
    createdDate = json['createdDate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['createdDate'] = this.createdDate;
    return data;
  }

  String get fullName {
    return '${firstName ?? ''} ${lastName ?? ''}';
  }
}

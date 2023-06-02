// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool isRegistered;
  String user;
  String mobile;
  int otp;
  String appSign;
  int id;

  LoginResponse({
    required this.isRegistered,
    required this.user,
    required this.mobile,
    required this.otp,
    required this.appSign,
    required this.id,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    isRegistered: json["is_registered"],
    user: json["user"],
    mobile: json["mobile"],
    otp: json["otp"],
    appSign: json["app_sign"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "is_registered": isRegistered,
    "user": user,
    "mobile": mobile,
    "otp": otp,
    "app_sign": appSign,
    "id": id,
  };
}

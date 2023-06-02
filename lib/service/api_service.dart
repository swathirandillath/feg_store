import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/login_response.dart';
import '../model/otp_response.dart';

String baseUrl = "https://blacksquad.dev.fegno.com/api/v1/user/";
var client = http.Client();

abstract class LoginRepository {
  Future<LoginResponse> loginWithNumber(
      String mobile, String appSign, String name);
}

class LoginRepo extends LoginRepository {
  @override
  Future<LoginResponse> loginWithNumber(
      String mobile, String appSign, String name) async {
    var body = {
      "mobile": mobile,
      "app_sign": appSign,
      "name": name,
    };
    final response =
        await client.post(Uri.parse("${baseUrl}enter_mobile/"), body: body);

    if (response.statusCode == 200) {
      return loginResponseFromJson(response.body);
    }
    throw Exception(response.statusCode);
  }
}

abstract class VerifyRepository {
  Future<OtpResponse> otpVerification(String mobile, String otp, String id);
}

class VerifyOtpRepo extends VerifyRepository {
  @override
  Future<OtpResponse> otpVerification(
      String mobile, String otp, String id) async {
    var body = {"mobile": mobile, "otp": otp, "id": id};
    final response =
        await client.post(Uri.parse("${baseUrl}enter_otp/"), body: body);

    var statusCode = response.statusCode;

    if (statusCode == 200) {
      return OtpResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }
}

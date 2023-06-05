import 'dart:convert';

import 'package:feg_store/model/plan_response.dart';
import 'package:feg_store/model/rating_response.dart';
import 'package:feg_store/model/review_response.dart';
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
    print(response.body);
    if (statusCode == 200) {
      return OtpResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }
}

abstract class AddRatingRepository {
  Future<RatingResponse> addRating(String userid, String rating, String token);
}

class RatingRepo extends AddRatingRepository {
  @override
  Future<RatingResponse> addRating(
      String userid, String rating, String token) async {
    var body = {
      "user_id": userid,
      "rating": rating,
    };
    print("body$body");
    var headers = {'Authorization': "Token $token"};
    final response = await client.post(Uri.parse("${baseUrl}add-rating/"),
        body: body, headers: headers);
    var statusCode = response.statusCode;
    print(statusCode);
    print(response);
    if (statusCode == 200) {
      return RatingResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }
}

abstract class ReviewRepository {
  Future<ReviewResponse> addReview(String userid, String review, String token);
}

class ReviewRepo extends ReviewRepository {
  @override
  Future<ReviewResponse> addReview(
      String userid, String review, String token) async {
    var body = {
      "user_id": userid,
      "review": review,
    };
    print("body========$body");
    var headers = {'Authorization': "Token $token"};
    final response = await client.post(Uri.parse("${baseUrl}add-review/"),
        body: body, headers: headers);
    var statusCode = response.statusCode;

    if (statusCode == 200) {
      return ReviewResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }
}

abstract class PlansRepository {
  Future<PlanList> fetchPlans(
    String token,
  );
}

class PlansRepo extends PlansRepository {
  @override
  Future<PlanList> fetchPlans(String token) async {
    var headers = {'Authorization': "Token $token"};
    try {
      final response = await client.get(
        Uri.parse("${baseUrl}list-plans/"),
        headers: headers,
      );
      print("plansStatuscode=${response.statusCode}");
      if (response.statusCode == 200) {
        return planListFromJson(response.body);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
    throw Exception();
  }
}

class NetworkError extends Error {}

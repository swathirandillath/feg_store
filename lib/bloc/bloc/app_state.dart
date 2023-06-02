

import 'package:flutter/cupertino.dart';

import '../../model/login_response.dart';
import '../../model/otp_response.dart';

@immutable
abstract class LoginPageState {}

class LoginPageInitial extends LoginPageState {}

class LoginPageLoading extends LoginPageState {}

class LoginPageLoaded extends LoginPageState {
  final LoginResponse response;

  LoginPageLoaded(this.response);
}

class LoginPageError extends LoginPageState {}

@immutable
abstract class OtpScreenState {}

class OtpScreenInitial extends OtpScreenState {}

class OtpScreenLoading extends OtpScreenState {}

class OtpScreenLoaded extends OtpScreenState {
  final OtpResponse otpResponse;

  OtpScreenLoaded(this.otpResponse);
}

class OtpScreenError extends OtpScreenState {}

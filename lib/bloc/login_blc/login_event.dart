import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginPageEvent {}
class SendData extends LoginPageEvent{
  final String mobile;
  final String appSign;
  final String name;
  SendData(this.mobile,this.appSign,this.name);
}
@immutable
abstract class OtpScreenEvent {}
class VerifyOtp extends OtpScreenEvent {
  final String mobile;
  final String otp;
  final String id;
  VerifyOtp(this.mobile, this.otp, this.id);
}

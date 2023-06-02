

import 'package:feg_store/model/otp_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_response.dart';
import '../../service/api_service.dart';
import 'app_event.dart';
import 'app_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  late LoginResponse response;
  final LoginRepo loginRepo;

  LoginPageBloc(this.loginRepo) : super(LoginPageInitial()) {
    on<LoginPageEvent>((event, emit) async {
      if (event is SendData) {
        emit(LoginPageLoading());
        await Future.delayed(const Duration(seconds: 2), () async {
          response = await loginRepo.loginWithNumber(
              event.mobile, event.appSign, event.name);
          emit(LoginPageLoaded(response));
        });
      }
    });
  }
}
class OtpBloc extends Bloc<OtpScreenEvent, OtpScreenState> {
  late OtpResponse otpResponse;
  final VerifyOtpRepo verifyOtpRepo;

  OtpBloc(this.verifyOtpRepo) : super(OtpScreenInitial()) {
    on<OtpScreenEvent>((event, emit) async {
      if (event is VerifyOtp) {
        emit(OtpScreenLoading());
        await Future.delayed(const Duration(seconds: 2), () async {
          otpResponse = await verifyOtpRepo.otpVerification(event.mobile, event.otp, event.id);

          emit(OtpScreenLoaded(otpResponse));
        });
      }
    });
  }
}



import 'package:feg_store/bloc/bloc/app_blocs.dart';
import 'package:feg_store/screen/login/login.dart';
import 'package:feg_store/screen/rating_review/rating_review.dart';
import 'package:feg_store/screen/verify_otp/otp.dart';
import 'package:feg_store/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../model/login_response.dart';


class RouteGenerator {
  final LoginPageBloc _loginPageBloc = LoginPageBloc(LoginRepo());
  final OtpBloc _otpBloc = OtpBloc(VerifyOtpRepo());

  Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginPageBloc>.value(
            value: _loginPageBloc,
            child: const LoginPage(),
          ),
        );
      case verifyRoute:
        final args = settings.arguments as LoginResponse;
        return MaterialPageRoute(builder: (_)=>BlocProvider<OtpBloc>.value(
          value:_otpBloc ,
          child:  OtpScreen(mobile: args.mobile, otp: args.otp.toString(),id: args.id.toString()),
        ));

      case ratingReview:
        return MaterialPageRoute(builder: (_)=>const RatingReview());


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
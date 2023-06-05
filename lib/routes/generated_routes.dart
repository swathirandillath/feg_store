import 'package:feg_store/bloc/bloc/app_blocs.dart';
import 'package:feg_store/model/otp_response.dart';
import 'package:feg_store/model/rating_response.dart';
import 'package:feg_store/screen/login/login.dart';
import 'package:feg_store/screen/plan_list/plan_list.dart';
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
  final RatingBloc _ratingBloc = RatingBloc(RatingRepo());
  final ReviewBloc _reviewBloc = ReviewBloc(ReviewRepo());
  final PlanBloc _planBloc = PlanBloc(PlansRepo());

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
        return MaterialPageRoute(
            builder: (_) => BlocProvider<OtpBloc>.value(
                  value: _otpBloc,
                  child: OtpScreen(
                      mobile: args.mobile,
                      otp: args.otp.toString(),
                      id: args.id.toString()),
                ));

      case ratingReviewRoute:
        final arguments = settings.arguments as OtpResponse;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<RatingBloc>.value(
                      value: _ratingBloc,
                    ),
                    BlocProvider<ReviewBloc>.value(
                      value: _reviewBloc,
                    ),
                  ],
                  child: RatingReview(
                    userid: arguments.userId.toString(),
                    token: arguments.token,
                  ),
                ));
      case pageListRoute:
        final arguments = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PlanBloc>.value(
                  value: _planBloc,
                  child: Plans(arguments.toString()),
                ));

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

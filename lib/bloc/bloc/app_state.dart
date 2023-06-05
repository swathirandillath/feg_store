import 'package:equatable/equatable.dart';
import 'package:feg_store/model/plan_response.dart';
import 'package:flutter/cupertino.dart';

import '../../model/login_response.dart';
import '../../model/otp_response.dart';
import '../../model/rating_response.dart';
import '../../model/review_response.dart';

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

@immutable
abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingLoaded extends RatingState {
  final RatingResponse ratingResponse;
  final String rating;
  RatingLoaded(this.ratingResponse, this.rating);
}
class SetRating extends RatingState{
  final double rating;
  final double ratingCount;
  SetRating(this.rating,this.ratingCount);
}
class RatingError extends RatingState {}

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final ReviewResponse reviewResponse;

  ReviewLoaded(this.reviewResponse);
}

class PageIndexChange extends ReviewState {}

class ReviewError extends RatingState {}

// @immutable
//
// abstract class PlanState extends Equatable {
//   const PlanState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class PlanInitial extends PlanState {}
//
// class PlanLoading extends PlanState {}
//
// class PlanLoaded extends PlanState {
//   final PlanList planList;
//   const PlanLoaded(this.planList);
// }
//
// class PlanError extends  PlanState {
//   final String? message;
//   const PlanError(this.message);
// }

@immutable
abstract class PlanState extends Equatable {}

class PlanLoadingState extends PlanState {
  @override
  List<Object?> get props => [];
}

class PlanLoadedState extends PlanState {
  final PlanList plan;

  PlanLoadedState(this.plan);

  @override
  List<Object?> get props => [plan];
}

class PlanErrorState extends PlanState {
  final String error;

  PlanErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

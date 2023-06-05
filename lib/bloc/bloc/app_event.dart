import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginPageEvent {}

class SendData extends LoginPageEvent {
  final String mobile;
  final String appSign;
  final String name;

  SendData(this.mobile, this.appSign, this.name);
}

@immutable
abstract class OtpScreenEvent {}

class VerifyOtp extends OtpScreenEvent {
  final String mobile;
  final String otp;
  final String id;

  VerifyOtp(this.mobile, this.otp, this.id);
}

@immutable
abstract class RatingEvent {}

class AddRating extends RatingEvent {
  final String userid;
  final String rating;
  final String token;
  AddRating(this.userid, this.rating, this.token);
}

class Rating extends RatingEvent {
   double rating;
   double ratingCount;
  Rating(this.rating, this.ratingCount);
}

@immutable
abstract class ReviewEvent {}

class AddReview extends ReviewEvent {
  final String userid;
  final String review;
  final String token;

  AddReview(this.userid, this.review, this.token);
}

// abstract class GetList extends Equatable {
//   const GetList();
//
//   @override
//   List<Object> get props => [];
// }
//
// class GetPlanList extends GetList {
//   final String token;
//   const GetPlanList(this.token);
//   }

@immutable
abstract class PageIndexEvents {}


@immutable
abstract class PlanEvent extends Equatable {
  const PlanEvent();
}

class LoadPlanEvent extends PlanEvent {
  final String token;
  const LoadPlanEvent(this.token);
  @override
  List<Object?> get props => [];
}
import 'package:feg_store/model/otp_response.dart';
import 'package:feg_store/model/plan_response.dart';
import 'package:feg_store/model/rating_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_response.dart';
import '../../model/review_response.dart';
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
        await Future.delayed(const Duration(seconds: 1), () async {
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
        await Future.delayed(const Duration(seconds: 1), () async {
          otpResponse = await verifyOtpRepo.otpVerification(
              event.mobile, event.otp, event.id);
          emit(OtpScreenLoaded(otpResponse));
        });
      }
    });
  }
}

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  late RatingResponse ratingResponse;
  final RatingRepo ratingRepo;

  RatingBloc(this.ratingRepo) : super(RatingInitial()) {
    on<RatingEvent>((event, emit) async {
      if (event is AddRating) {
        emit(RatingLoading());
        await Future.delayed(const Duration(seconds: 1), () async {
          ratingResponse = await ratingRepo.addRating(
              event.userid, event.rating, event.token);
          emit(RatingLoaded(ratingResponse,event.rating));
        });
      }else if(event is Rating){
        event.ratingCount=event.rating;
        emit(SetRating(event.rating,event.ratingCount));
      }
    });
  }
}

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  late ReviewResponse reviewResponse;
  final ReviewRepo reviewRepo;

  ReviewBloc(this.reviewRepo) : super(ReviewInitial()) {
    on<ReviewEvent>((event, emit) async {
      if (event is AddReview) {
        emit(ReviewLoading());
        await Future.delayed(const Duration(seconds: 1), () async {
          reviewResponse = await reviewRepo.addReview(
              event.userid, event.review, event.token);
          emit(ReviewLoaded(reviewResponse));
        });
      }
    });
  }
}

//
// class PlanBloc extends Bloc<GetList, PlanState> {
//   PlanBloc(PlansRepo plansRepo) : super(PlanInitial()) {
//     on<GetPlanList>((event, emit) async {
//       try {
//         print("inside block");
//         emit(PlanLoading());
//         final mList = await PlansRepo().fetchPlans(event.token);
//         print("MLIST===$mList");
//         emit(PlanLoaded(mList));
//       } on NetworkError {
//         emit(const PlanError("Failed to fetch data. is your device online?"));
//       }
//     });
//   }
// }

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlansRepository _plansRepository;

  PlanBloc(this._plansRepository) : super(PlanLoadingState()) {
    on<PlanEvent>((event, emit) async {
      if(event is LoadPlanEvent){
        emit(PlanLoadingState());
        try {
          final plan = await _plansRepository.fetchPlans(event.token);
          emit(PlanLoadedState(plan));
        } catch (e) {
          emit(PlanErrorState(e.toString()));
        }
      }

    });
  }
}

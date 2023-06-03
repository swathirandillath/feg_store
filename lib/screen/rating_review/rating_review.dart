

import 'package:feg_store/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../bloc/bloc/app_blocs.dart';
import '../../bloc/bloc/app_event.dart';
import '../../bloc/bloc/app_state.dart';
import '../../constants/app_colors.dart';
import '../../model/login_response.dart';
import '../../service/api_service.dart';
import '../verify_otp/otp.dart';

class RatingReview extends StatefulWidget {
  const RatingReview({
    super.key,
  });

  @override
  State<RatingReview> createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Rating page is in progress'),),
    );
  }



}

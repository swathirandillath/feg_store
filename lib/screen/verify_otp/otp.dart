import 'dart:async';
import 'package:feg_store/model/login_response.dart';
import 'package:feg_store/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../bloc/bloc/app_blocs.dart';
import '../../bloc/bloc/app_event.dart';
import '../../bloc/bloc/app_state.dart';
import '../../constants/constants.dart';
import '../../model/otp_response.dart';

class OtpScreen extends StatefulWidget {
  final String? mobile;
  final String? otp;
  final String? id;

  const OtpScreen(
      {Key? key, required this.mobile, required this.otp, required this.id})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();

  late Timer _timer;
  String otp = "";
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OtpBloc, OtpScreenState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OtpScreenLoaded) {
              buildLoadedLayout(state.otpResponse);
              print('OTP Verify buildLoadedLayout');

            } else if (state is OtpScreenError) {
              print("error");
            }
            return Padding(
              padding: const EdgeInsets.all(26.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'FEGSTORE',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Verify your number',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Please enter the 4 digit otp sent to  ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey)),
                        Text('number ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 25,
                        ),
                        Form(
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            obscureText: false,
                            blinkWhenObscuring: true,
                            animationType: AnimationType.scale,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            pinTheme: PinTheme(
                              fieldOuterPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              activeFillColor: Colors.white,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black,
                              disabledColor: Colors.black,
                              selectedColor: Colors.black,
                              fieldHeight: 45,
                              fieldWidth: 45,
                              borderWidth: 1,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: false,
                            keyboardType: TextInputType.number,
                            onCompleted: (value) {
                              print('onCompleted $value');
                                otp = value;
                            },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              return true;
                            },
                          ),
                        ),
                        _start != 0
                            ? Text(
                                '00:${_start.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.red),
                              )
                            : Container()
                      ],
                    ),
                    MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: const Color(0xff4d53e5),
                      onPressed: () {
                        if (widget.otp == otp) {
                          _timer.cancel();
                          BlocProvider.of<OtpBloc>(context).add(VerifyOtp(
                              widget.mobile.toString(),
                              widget.otp.toString(),
                              widget.id.toString()));
                        } else {
                          showToast('OTP does not match');
                        }
                      },
                      child: Center(
                        child: (state is OtpScreenLoading)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Verify",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Didn't receive the code? ",
                          ),
                          TextSpan(
                            text: ' Resend',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void buildLoadedLayout(OtpResponse otpResponse) {

    WidgetsBinding.instance.addPostFrameCallback((_){
      showToast('OTP Verified');
      Navigator.pushReplacementNamed(
          context,
          ratingReview,
      );

    });
  }
}

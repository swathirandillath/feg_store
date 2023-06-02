import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../bloc/bloc/app_blocs.dart';
import '../bloc/bloc/app_event.dart';
import '../bloc/bloc/app_state.dart';
import '../model/otp_response.dart';
import '../rating_page/rating_post.dart';

class OtpScreen extends StatefulWidget {
  String mobile;
  String otp;
  String id;

  OtpScreen(
      {Key? key, required this.mobile, required this.otp, required this.id})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();

  late Timer _timer;
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
            } else if (state is OtpScreenError) {
              print("error");
            }
            return
              Padding(
                padding: const EdgeInsets.all(26.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'FEGSTORE',
                        style: TextStyle(
                            color: Color(0xff4d53e5),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const Text(
                        'Verify your number',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Please enter the 4 digit otp sent to  ',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const Text(
                            'number ',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
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
                              animationDuration: const Duration(
                                  milliseconds: 300),
                              enableActiveFill: false,
                              keyboardType: TextInputType.number,
                              onCompleted: (value) {
                                print('onCompleted $value');
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
                            _start.toString(),
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
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
                          BlocProvider.of<OtpBloc>(context).add(
                              VerifyOtp(widget.mobile, widget.otp, widget.id));
                        },
                        child: Center(
                          child: (state is OtpScreenLoading)
                              ? const CircularProgressIndicator(color: Colors
                              .white
                            ,):const Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Didn't receive the code? ",
                            ),
                            TextSpan(
                                text: ' Resend',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Rating()));
  }

}

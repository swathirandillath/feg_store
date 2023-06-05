import 'package:feg_store/constants/constants.dart';
import 'package:feg_store/util/utils.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginPageBloc, LoginPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoginPageLoaded) {
            buildLoadedLayout(state.response);
          } else if (state is LoginPageError) {}
          return Padding(
            padding: const EdgeInsets.all(26.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Welcome To',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.black),
                          ),
                          Text(
                            'FEGSTORE',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            height: 10,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Login or SignUp"),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            height: 10,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: numberController,
                                decoration: InputDecoration(
                                  hintText: "please enter your phone number",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10) //
                                      ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10) //
                                      ),
                                ),
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "please enter your number";
                                  }
                                  else if(value.length!=10){
                                    return " please enter a valid number";
                                  }
                                  return null;

                                },
                              ),
                            ),
                          ),
                          MaterialButton(
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Palette.primary,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginPageBloc>(context).add(
                                    SendData(numberController.text, "phone",
                                        "name"));
                              }
                            },
                            child: Center(
                              child: (state is LoginPageLoading)
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Continue",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                const Text("By clicking Continue you agree to",
                                    style: TextStyle(color: Colors.grey)),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: ' and',
                                          style: TextStyle(color: Colors.grey)),
                                      TextSpan(
                                          text: ' Terms & Conditions',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  onPressed: () {},
                                  child: Row(children: const [
                                    Text(
                                      "Skip",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Icon(
                                      Icons.arrow_circle_right_rounded,
                                      color: Colors.grey,
                                    )
                                  ]),
                                ),
                              ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void buildLoadedLayout(LoginResponse response) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showToast('OTP is : ${response.otp.toString()}');
      Navigator.pushNamed(context, verifyRoute, arguments: response);
    });
  }


}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_blc/login_blocs.dart';
import '../../bloc/login_blc/login_event.dart';
import '../../bloc/login_blc/login_state.dart';
import '../../model/login_response.dart';
import '../../service/api_service.dart';
import '../otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController numberController = TextEditingController();

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
          } else if (state is LoginPageError) {
            print("error");
          }
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
                        children: const [
                          Text(
                            'Welcome To',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          Text(
                            'FEGSTORE',
                            style: TextStyle(
                                color: Color(0xff4d53e5),
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: numberController,
                              decoration: InputDecoration(
                                hintText: "please enter your phone number",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(10) //
                                    ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(10) //
                                    ),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10) //
                                    ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: const Color(0xff4d53e5),
                            onPressed: () =>
                                BlocProvider.of<LoginPageBloc>(context).add(
                                    SendData(numberController.text, "phone",
                                        "name")),
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
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
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
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  BlocProvider<OtpBloc>.value(
            value: OtpBloc(VerifyOtpRepo()),
            child:OtpScreen(
            mobile: response.mobile,
            otp: response.otp.toString(),
            id: response.id.toString()))));
  }


}

import 'package:feg_store/routes/generated_routes.dart';
import 'package:feg_store/screen/login/login.dart';
import 'package:feg_store/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/app_blocs.dart';
import 'constants/constants.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
        initialRoute: loginRoute,
        onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}

import 'package:feg_store/routes/generated_routes.dart';
import 'package:feg_store/screen/login/login.dart';
import 'package:feg_store/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/app_blocs.dart';
import 'constants/app_colors.dart';
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
      theme: ThemeData(
        primarySwatch: generateMaterialColor(Palette.primary),
        colorScheme: ThemeData().colorScheme.copyWith(primary: Palette.primary),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,color: Palette.primary),
          bodyMedium: TextStyle(fontSize: 14.0,color: Colors.black),
        ),
      ),
        initialRoute: loginRoute,
        onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}

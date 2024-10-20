import 'package:flutter/material.dart';
import 'package:imogoat/core/rest_client/service_locator.dart';
import 'package:imogoat/screens/home/home.dart';
import 'package:imogoat/screens/auth/login.dart';
import 'package:imogoat/screens/auth/sign.dart';
import 'package:imogoat/screens/home/initialPage.dart';
import 'package:imogoat/screens/owner/flow/step_three_immobile.dart';
import 'package:imogoat/screens/owner/flow/step_two_immobile.dart';
// import 'package:imogoat/styles/light.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: lightThema,
      title: 'ImoGoat',
      initialRoute: '/initial',
      routes: {
        "/": (context) => const LoginPage(),
        "/signup": (context) => const SignUpPage(),
        "/home": (context) => const HomePage(),
        "/initial": (context) => const PaginaInicial(),
        "/step_two": (context) => const StepTwoCreateImmobilePage(),
        "/step_three": (context) => const StepThreeCreateImmobilePage(),
      },
    );
  }
}


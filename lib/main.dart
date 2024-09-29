import 'package:flutter/material.dart';
import 'package:imogoat/core/rest_client/service_locator.dart';
import 'package:imogoat/screens/home/home.dart';
import 'package:imogoat/screens/auth/login.dart';
import 'package:imogoat/screens/auth/sign.dart';
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
      initialRoute: '/',
      routes: {
        "/": (context) => const LoginPage(),
        "/signup": (context) => const SignUpPage(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}


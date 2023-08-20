import 'package:flutter/material.dart';
import 'package:charless_06/phone_auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const PhoneAuthScreen(), // Здесь вызываем экран авторизации
    );
  }
}


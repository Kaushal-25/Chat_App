import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Karo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          // In app bar theme same attributes for all the screens
          iconTheme: IconThemeData(
            color: Colors.black,
              size: 28
          ),
          centerTitle: true,
          elevation: 1,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
          ),
          backgroundColor: Colors.white
        ),
      ),
      home: Login_Screen(),
    );
  }
}



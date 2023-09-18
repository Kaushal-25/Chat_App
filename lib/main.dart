import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // for setting the full screen spalsh screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // for viewing only in potrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value) {
      Firebase.initializeApp();
      runApp(const MyApp());
    });


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
            fontWeight: FontWeight.w600,color: Colors.black,fontSize: MediaQuery.of(context).size.width*.055
          ),
          backgroundColor: Colors.white60
        ),
      ),
      home: Splash_Screen(),
    );
  }
}



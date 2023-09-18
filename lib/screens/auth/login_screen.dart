import 'dart:developer';
import 'dart:io';

import 'package:chat_app/api/api.dart';
import 'package:chat_app/helper/dialog.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {



  // initstate mai aninamtion ke liye dale hai
bool  _isanimate = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isanimate = true;
      });
    }
    );
  }
  _handleGoogleBtnClick() {
    // showing progress bar in centre
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if(user != null) {
        log("/nUser: ${user.user}");
        log("/nUesr.AdditionalInfo: ${user.additionalUserInfo}");

        if((await APIs.userExists())) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home_Screeen(),));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Home_Screeen(),));
          });
        }


      }
    });
  }
Future<UserCredential?> _signInWithGoogle() async {
    // using try and catch to show a snack bar when it is not connected to internet
    try{
      await InternetAddress.lookup("google.com");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    }catch(e){
      log("_signInWithGoogle: $e");
      // displaying snack bar pop up
      Dialogs.showSnackBar(context, "Something went wrong (Check Internet)");
      return null;
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to We Chat",),
      ),
      body: Stack(
        children: [AnimatedPositioned
        // using mediiaQuery because to make the screen dynamic for all the phones
          (top: MediaQuery.of(context).size.height*.15,
            width: MediaQuery.of(context).size.width*.52,
            right: _isanimate ? MediaQuery.of(context).size.width*.25 : -MediaQuery.of(context).size.width*.52,
            duration: Duration(seconds: 1),
            child: Image.asset("assets/chat.png")),
        Positioned
          (top: MediaQuery.of(context).size.height*.60,
            width: MediaQuery.of(context).size.width*.85,
            height: MediaQuery.of(context).size.height*.07,
            left: MediaQuery.of(context).size.width*.07,
            child:
            // Sign in button with icon
            ElevatedButton.icon(    // Sign in button with icon
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.black26,
                   shape: StadiumBorder(),
                   elevation: 1
    ),
                onPressed: () {
                   _handleGoogleBtnClick();
                },
            icon: Image.asset("assets/google.png",
              height: MediaQuery.of(context).size.height*.05,),
            label:
                // using Rich text for different textstyles in same line
            RichText(text: TextSpan(children: [
              TextSpan(text: " Log In With ", style: TextStyle(
                fontSize: MediaQuery.of(context).size.width*.04
              )),
              TextSpan(text: "Google",style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: MediaQuery.of(context).size.width*.06
              ))
            ]),)))],
      ),
    );
  }
}

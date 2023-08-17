import 'package:flutter/material.dart';
class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to We Chat"),
      ),
      body: Stack(
        children: [Positioned
          (top: MediaQuery.of(context).size.height*.15,
            width: MediaQuery.of(context).size.width*.52,
            left: MediaQuery.of(context).size.width*.25,
            child: Image.asset("assets/chat.png")),
        Positioned(top: MediaQuery.of(context).size.height*.60,
            width: MediaQuery.of(context).size.width*.85,
            height: MediaQuery.of(context).size.height*.07,
            left: MediaQuery.of(context).size.width*.07,
            child: ElevatedButton.icon(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.black26,
                   shape: StadiumBorder(),
                   elevation: 1
    ),
                onPressed: () {},
            icon: Image.asset("assets/google.png",
              height: MediaQuery.of(context).size.height*.055,),
            label: RichText(text: TextSpan(children: [
              TextSpan(text: " Sign In With ", style: TextStyle(
                fontSize: 17
              )),
              TextSpan(text: "Google",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 22
              ))
            ]),)))],
      ),
    );
  }
}

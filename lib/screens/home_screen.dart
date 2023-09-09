import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home_Screeen extends StatefulWidget {
  const Home_Screeen({Key? key}) : super(key: key);

  @override
  State<Home_Screeen> createState() => _Home_ScreeenState();
}

class _Home_ScreeenState extends State<Home_Screeen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("We Chat"),
        leading: Icon(Icons.home_outlined,size: MediaQuery.of(context).size.width*.075,),
        actions: [
          // search user button
          IconButton(onPressed: () {}, icon: Icon(Icons.search,size: MediaQuery.of(context).size.width*.075,),),
          // more vertical user button
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert,size: MediaQuery.of(context).size.width*.075,))
        ],
      ),
      // bottom right side button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
        },
        child: Icon(Icons.add_circle,size: MediaQuery.of(context).size.width*.1,),
      ),
    );
  }
}

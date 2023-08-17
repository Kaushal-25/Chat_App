import 'package:flutter/material.dart';

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
        leading: Icon(Icons.home_outlined),
        actions: [
          // search user button
          IconButton(onPressed: () {}, icon: Icon(Icons.search,),),
          // more vertical user button
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      // bottom right side button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_circle),
      ),
    );
  }
}

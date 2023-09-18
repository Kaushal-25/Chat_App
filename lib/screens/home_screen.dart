import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/api/api.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/screens/profile_screen.dart';
import 'package:chat_app/widgets/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home_Screeen extends StatefulWidget {
  const Home_Screeen({Key? key}) : super(key: key);

  @override
  State<Home_Screeen> createState() => _Home_ScreeenState();
}

class _Home_ScreeenState extends State<Home_Screeen> {

   // for storing all user
   List<ChatUser> _list = [];
   // for storing searched items
   final List<ChatUser> _searchlist = [];
   // for storing search status
   bool _isSearching = false;

   @override
  void initState() {
    super.initState();
    APIs.getSelInfo();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        // if search is on & back button is pressed then close search
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
          return Future.value(false);
          } else {
          return Future.value(true);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white60,
          appBar: AppBar(
            title: _isSearching ? TextField(
              decoration: InputDecoration(border: InputBorder.none,
              hintText: "Name, Email"),
              autofocus: true,
              onChanged: (val) {
                _searchlist.clear();

                for(var i in _list) {
                  if(i.name.toLowerCase().contains(val.toLowerCase()) ||
                      i.email.toLowerCase().contains(val.toLowerCase())) {
                    _searchlist.add(i);
                  }
                  setState(() {
                    _searchlist;
                  });

                }

              },
            ) : Text("We Chat"),
            leading: Icon(Icons.home_outlined,size: MediaQuery.of(context).size.width*.075,),
            actions: [
              // search user button
              IconButton(onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              },
                icon: Icon( _isSearching ? CupertinoIcons.clear_circled_solid
                    :Icons.search,size: MediaQuery.of(context).size.width*.075,),),
              // more vertical user button
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile_Screen(user: APIs.me),));
              },
                  icon: Icon(Icons.more_vert,size: MediaQuery.of(context).size.width*.075,))
            ],
          ),
          // bottom right side button
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            },
            child: Icon(Icons.add_circle,size: MediaQuery.of(context).size.width*.1,),
          ),

          body: StreamBuilder(
            // stream builder to use data from firestore
            stream: APIs.getAllUsers(),
            builder: (context, snapshot) {

              switch (snapshot.connectionState) {
                // if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  // if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:

                  final data = snapshot.data?.docs;
                  _list = data?.map((e) => ChatUser.fromJson(e.data())).toList()  ?? [] ;

                  if (_list.isNotEmpty) {
                    return ListView.builder(
                        itemCount: _isSearching ? _searchlist.length : _list.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*.005),
                        itemBuilder: (context, index) {
                          return ChatUserCard(user: _isSearching ? _searchlist[index]  :_list[index],);
                          // return Text("Name: ${list[index]}");
                        });
                  }
                  else {
                    return Center(child: Text("No Connection Found!",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*.07,
                        color: Colors.black,),));
                  }
              }



            },
          ),
        ),
      ),
    );
  }
}

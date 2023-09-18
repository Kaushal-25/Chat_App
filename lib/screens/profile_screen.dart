

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/api/api.dart';
import 'package:chat_app/helper/dialog.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class Profile_Screen extends StatefulWidget {
  final ChatUser user;
  const Profile_Screen({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {

  // for updating the name and about section
  final _formkey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return
      //  using gestureDetector to hide the keyboard by tapping outside the text form field
      GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Text("Profile Screen"),
        ),
        // bottom right side button
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Logout"),
          icon: Icon(Icons.logout),
          onPressed: () async {
            // for showinng progress bar
            Dialogs.showProgressBar(context);
            // for signout
            await APIs.auth.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                // for removing progress bar
                Navigator.pop(context);
                // for removing home screen
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Screen(),));
              });
            });

          },

        ),

        body: Form(
          key: _formkey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05,),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // user profile Icon
                  SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  Stack(
                    children: [
                      _image != null ?
                  ClipRRect(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1),
          child: Image.file(File(_image!),
            height: MediaQuery.of(context).size.height*0.2,
            width:MediaQuery.of(context).size.width*0.4 ,
            fit: BoxFit.cover,
          ),
        )
                          :
                      ClipRRect(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.1),
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height*0.2,
                          width:MediaQuery.of(context).size.width*0.4 ,
                          fit: BoxFit.cover,
                          imageUrl: widget.user.image,
                          errorWidget: (context, url, error) =>   CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      // edit button
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: MaterialButton(onPressed: () {
                          _ShowBottomSheet();
                        },
                          elevation: 1,
                          color: Colors.white,
                          shape: CircleBorder(),
                        child: Icon(Icons.edit),),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  Text(widget.user.email,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,),),
                  SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Name Input Field
                  TextFormField(
                    onSaved: (val) => APIs.me.name = val ?? "",
                    validator: (val) => val != null && val.isNotEmpty ? null : "Require Field",
                    cursorColor: Colors.black,
                    initialValue: widget.user.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("Name"),
                      hintText: "eg- \"Happy Singh\"",
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.person,color: Colors.black54,)
                    ),
                  ),
                  // About Input Field
                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  TextFormField(
                    onSaved: (val) => APIs.me.about = val ?? "",
                    validator: (val) => val != null && val.isNotEmpty ? null : "Require Field",
                    cursorColor: Colors.black,
                    initialValue: widget.user.about,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("About"),
                        hintText: "eg- \"Happy Me\"",
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.info_outline,color: Colors.black54,)
                    ),
                  ),
                  // Update Input Field
                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  ElevatedButton.icon(onPressed: () {
                    if(_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      APIs.updateUserInfo().then((value) {
                        Dialogs.showSnackBar(context, 'Profile Updated Successfully');
                      });
                    }
                  },
                      icon: Icon(Icons.edit),
                      label: Text("Update"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.height*.15, MediaQuery.of(context).size.height*.055),
                      shape: StadiumBorder()
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _ShowBottomSheet () {
    showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30))) ,
        builder: (_){
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.05,bottom: MediaQuery.of(context).size.height*.07),
        children: [
          Text(" PickProfile Picture",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MediaQuery.of(context).size.height*.022,fontWeight: FontWeight.w500),
          ),
        Row(mainAxisAlignment: (MainAxisAlignment.spaceEvenly),
          children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                fixedSize: Size(MediaQuery.of(context).size.width*.25, MediaQuery.of(context).size.height*.25)
              ),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
// Pick an image.
                final XFile? image = await picker.pickImage(source: ImageSource.gallery,
                    imageQuality: 80);
                if(image != null) {
                  log("Image Path : ${image.path} -- MimeType: ${image.mimeType}");
                  setState(() {
                    _image = image.path;
                  });
                  _image = image.path;
                  APIs.updateProfilePicture(File(_image !));
                  // for hiding bottom sheet
                  Navigator.pop(context);
                }
              }, child: Image.asset("assets/addImage.jpg")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  fixedSize: Size(MediaQuery.of(context).size.width*.25, MediaQuery.of(context).size.height*.25)
              ),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
// Pick from camera
                final XFile? image = await picker.pickImage(source: ImageSource.camera,
                imageQuality: 80);
                if(image != null) {
                  log("Image Path : ${image.path}}");
                  setState(() {
                    _image = image.path;
                  });
                  APIs.updateProfilePicture(File(_image !));
                  Navigator.pop(context);
                }
              }, child: Image.asset("assets/addCamera.png"))
        ],)
        ],
      );
    });
  }
}

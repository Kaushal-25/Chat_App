import 'dart:io';
import 'dart:math';
import 'dart:developer';
import 'package:chat_app/model/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for acessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;
  // to return current user
  static User get  user => auth.currentUser!;

  // for storing self information
  static late  ChatUser me;


  // for checking if the user exists or not
  static Future<bool> userExists() async {
    final documentSnapshot = await firestore.collection("users").doc(auth.currentUser!.uid).get();
    return documentSnapshot.exists;

  }

  // for getting current user info
  static Future<void> getSelInfo() async {
    await firestore.collection("users").doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      }else{
        await createUser().then((value) => getSelInfo());
      }
    } );
  }

// for creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        createdAt: time,
        image: user.photoURL.toString(),
        lastActive: time,
        about: "Hey, I am using We Chat",
        name: user.displayName.toString(),
        id: user.uid,
        isOnline: false,
        email: user.email.toString(),
        pushToken: "");
    return await firestore.collection("users").doc(user.uid).set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllUsers() {
    return firestore.collection("users").where("id",isNotEqualTo: user.uid).snapshots();
  }

  // for updating user information
  static Future<void> updateUserInfo() async {
    await firestore.collection("users").doc(user.uid).update({
      "name" : me.name,
      "about" : me.about
    });
  }

  // update profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split(".").last;
    print("Extension: $ext");
    final ref = storage.ref().child("profile_pictures/${user.uid}.$ext");
    await ref
        .putFile(file, SettableMetadata(contentType: "image/$ext"))
        .then((p0) {
      print("Data Transferred: ${p0.bytesTransferred / 1000} kb");
    });
    me.image = await ref.getDownloadURL();
    await firestore.collection("users").doc(user.uid).update({
      "image" : me.image,
    });
  }
  }

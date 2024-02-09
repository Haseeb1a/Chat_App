import 'dart:developer';

import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/widgets/alretbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMehods {
  Future<UserCredential?> signInWithGoogle(contex) async {
    try {
      // Trigger the authentication flow

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\nsignInWithGooglepp $e');
      Dialogs(contex, 'something  Went wrong (Check Inernet)');
      return null;
    }
  }

  // Userexiting or Not
  static Future<bool> userExiting() async {
    return (await Base.firestore
            .collection('users')
            .doc(Base.auth.currentUser!.uid)
            .get())
        .exists;
  }

  // Creataing new user
  static Future<void> creatingUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final user = ChatUser(
        name: Base.auth.currentUser!.displayName.toString(),
        image: Base.auth.currentUser!.photoURL.toString(),
        about: 'i am using chatx',
        id: Base.auth.currentUser!.uid,
        createdAt: time,
        isOnline: false,
        isActive: time,
        email: Base.auth.currentUser!.email.toString(),
        pushTocken: '');
    return (await Base.firestore
        .collection('users')
        .doc(Base.auth.currentUser!.uid)
        .set(user.toJson()));
  }
}

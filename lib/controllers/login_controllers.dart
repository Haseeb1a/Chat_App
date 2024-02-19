import 'dart:developer';

import 'package:chatx/services/auth_methods.dart';
import 'package:chatx/views/home_users/home_page.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // calling the google auth
  singingWithGoogle(BuildContext context) async {
    await AuthMehods().signInWithGoogle(context).then((user) async {
      log('\nUser:${user!.user}');
      log('\nUseradditionalUserInfo:${user.additionalUserInfo}');
      if (await AuthMehods.userExiting()) {
       await Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
      await  AuthMehods.creatingUser().then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage())));
      }
    });
  }

//    Future checkUserExiting(context)async{
//  if (await AuthMehods.userExiting()) {
//        Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => HomePage()));
//     }else{
//        Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()));
//     }
//    }
}

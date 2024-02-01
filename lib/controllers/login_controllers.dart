import 'dart:developer';

import 'package:chatx/services/auth_methods.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // calling the google auth
  singingWithGoogle(BuildContext context) async {
    await AuthMehods().signInWithGoogle(context).then((user) {
      log('\nUser:${user!.user}');
      log('\nUseradditionalUserInfo:${user.additionalUserInfo}');
    });
  }
}

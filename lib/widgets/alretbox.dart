import 'package:flutter/material.dart';

class Dialogs {
  Dialogs(BuildContext contex, String s);

  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black.withOpacity(3),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/services/auth_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ApiServices {
  static late CharUser currentUser;
  // get all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return Base.firestore
        .collection('users')
        .where('id', isNotEqualTo: Base.auth.currentUser!.uid)
        .snapshots();
  }

  // geting current user
  static Future<void> getCurrentUser() async{
    return Base.firestore
        .collection('users')
        .doc(Base.auth.currentUser!.uid)
        .get()
        .then((user)async {
      if (user.exists) {
        currentUser = CharUser.fromJson(user.data()!);
      }else   {
    await AuthMehods.creatingUser().then((value) => getCurrentUser());
      }
    });
  }
}

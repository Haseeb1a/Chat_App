import 'dart:developer';
import 'dart:io';
import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/services/auth_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ApiServices {
  static late ChatUser currentUser;
  // get all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return Base.firestore
        .collection('users')
        .where('id', isNotEqualTo: Base.auth.currentUser!.uid)
        .snapshots();
  }

  // geting current user
  static Future<void> getCurrentUser() async {
    return Base.firestore
        .collection('users')
        .doc(Base.auth.currentUser!.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        currentUser = ChatUser.fromJson(user.data()!);
      } else {
        await AuthMehods.creatingUser().then((value) => getCurrentUser());
      }
    });
  }

  // user Profile Update
  Future<void> updateProfile() async {
    await Base.firestore
        .collection('users')
        .doc(Base.auth.currentUser!.uid)
        .update({'name': currentUser.name, "about": currentUser.about});
  }

// Storing on the firestore
  static Future<void> updateProfilePicture(File file) async {
    final extantion = file.path.split('.').last;
    print(extantion);
    final references = Base.storage
        .ref('profilePicture${Base.auth.currentUser!.uid}.$extantion');
    await references
        .putFile(file, SettableMetadata(contentType: 'image/$extantion'))
        .then((p0) {
      log('Data Trasferred ${p0.bytesTransferred / 1000} kb');
    });
    currentUser.image = await references.getDownloadURL();
    await Base.firestore
        .collection('users')
        .doc(Base.auth.currentUser!.uid)
        .update({
      'image': currentUser.image,
    });
  }
}

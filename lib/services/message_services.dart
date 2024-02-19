import 'package:chatx/constrains/base_objects.dart';
import 'package:chatx/model/chat_user_model.dart';
import 'package:chatx/model/message_model.dart';
import 'package:chatx/services/auth_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MessageServices {
  static User user = Base.auth.currentUser!;

  static String getConverSationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return Base.firestore
        .collection('chats/${getConverSationID(user.id)}/messages/')
        .snapshots();
  }

  static Future<void> sendMessage(ChatUser chatUser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(
        told: chatUser.id,
        msg: msg,
        read: '',
        type: Type.text,
        formId: user.uid,
        sent: time);

    final refesrensed = Base.firestore
        .collection('chats/${getConverSationID(chatUser.id)}/messages/');
    await refesrensed.doc(time).set(message.tojson());
  }

  // get only lastmessage
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
      return Base.firestore
        .collection('chats/${getConverSationID(user.id)}/messages/')
        .orderBy('send',descending: true).limit(1)
        .snapshots();
  }
}

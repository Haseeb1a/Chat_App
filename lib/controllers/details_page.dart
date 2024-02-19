import 'package:chatx/model/message_model.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  List<Message> messages = [];
  bool isEmoji = false;
  checkFlip() {
    isEmoji = !isEmoji;
    notifyListeners();
  }
}

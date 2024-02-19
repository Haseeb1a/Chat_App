import 'package:chatx/model/chat_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  List<ChatUser> users = [];
  List<ChatUser> searchuser = [];
  bool is_serching = false;

  void isSearching() {
    is_serching = !is_serching;
    notifyListeners();
  }

  void searcheduser(String value) {
    // bool is_serching = true;
    notifyListeners();
    searchuser.clear();
    notifyListeners;
    for (var element in users) {
      if (element.name.toLowerCase().contains((value.toLowerCase())) ||
          element.email.toLowerCase().contains((value.toLowerCase()))) {
        searchuser.add(element);
      }
      searchuser;
      notifyListeners();
    }
  }

  String getLastMessageTime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }
    return '${sent.day} ${getMonth(sent)}';
  }

  String getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sept";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return 'N/A';
  }
}

import 'package:chatx/model/chat_user_model.dart';
import 'package:flutter/foundation.dart';

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
}

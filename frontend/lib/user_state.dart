import 'package:flutter/cupertino.dart';

class UserState extends ChangeNotifier {

  String name = "Clayton Chu";
  String username = "clayton";
  String email = "clayton@example.com";

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
}
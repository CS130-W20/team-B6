import 'package:flutter/cupertino.dart';

class UserState extends ChangeNotifier {
  UserState({this.name, this.username, this.email, this.id, this.description});

  int id = 0;
  String name = "";
  String username = "";
  String email = "";
  String description = "";

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      id: json['pk'],
      name: "${json['fields']['first_name']} ${json['fields']['last_name']}",
      username: json['fields']['user_name'],
      email: json['fields']['email_address'],
      description: json['fields']['description']
    );
  }
}
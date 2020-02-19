import 'package:flutter/cupertino.dart';

class UserState extends ChangeNotifier {
  UserState({this.firstname, this.lastname, this.username, this.email, this.id, this.description});

  int id = 0;
  String firstname = "";
  String lastname = "";
  String username = "";
  String email = "";
  String description = "";

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setFirstName(String firstname) {
    this.firstname = firstname;
    notifyListeners();
  }

  void setLastName(String lastname) {
    this.lastname = lastname;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      id: json['pk'],
      firstname: json['fields']['first_name'],
        lastname: json['fields']['last_name'],
      username: json['fields']['user_name'],
      email: json['fields']['email_address'],
      description: json['fields']['description']
    );
  }
}
import 'package:flutter/cupertino.dart';

class UserState extends ChangeNotifier {
  UserState({this.firstname, this.lastname, this.username, this.email, this.id, this.description});

  int id = 0;
  String firstname = "";
  String lastname = "";
  String username = "";
  String email = "";
  String description = "";
  String profilepic = "";

  /// If a different user logs in, the username is changed.
  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  /// If a different user logs in or the user edits this, the first name is changed.
  void setFirstName(String firstname) {
    this.firstname = firstname;
    notifyListeners();
  }

  /// If a different user logs in or the user edits this, the last name is changed.
  void setLastName(String lastname) {
    this.lastname = lastname;
    notifyListeners();
  }

  /// If a different user logs in or the user edits this, the email is changed.
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  /// If a different user logs in or the user edits this, the user description is changed.
  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void setProfilePic(String url) {
    this.profilepic = url;
    notifyListeners();
  }

  /// Automatically creates a user state from a JSON user object.
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
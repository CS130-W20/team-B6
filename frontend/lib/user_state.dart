import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlook/managers/data_manager.dart';

class UserState {
  UserState({this.username, this.firstname, this.lastname, this.email, this.description, this.profilepic, this.id});

  static const USERNAME = 'username';
  static const FIRSTNAME = 'firstname';
  static const LASTNAME = 'lastname';
  static const EMAIL = 'email';
  static const DESCRIPTION = 'description';
  static const PROFILEPIC = 'profilepic';
  static const ID = 'id';

  String username;
  String firstname;
  String lastname;
  String email;
  String description;
  String profilepic;
  int id;

  static getListenable() {
    return Hive.box(DataManager.USER_BOX).listenable();
  }

  static UserState getState() => UserState(
      username: getUserName(),
      firstname: getFirstName(),
      lastname: getLastName(),
      email: getEmail(),
      description: getDescription(),
      profilepic: getProfilePic(),
      id: getId()
    );

  static void set(String key, var value) {
    var userBox = Hive.box(DataManager.USER_BOX);
    userBox.put(key, value);
  }

  static get(String key) {
    var userBox = Hive.box(DataManager.USER_BOX);
    return userBox.get(key);
  }

  static String getUserName() {
    return get(USERNAME);
  }

  /// If a different user logs in, the username is changed.
  static void setUserName(String username) {
    set(USERNAME, username);
  }

  static String getFirstName() {
    return get(FIRSTNAME);
  }

  /// If a different user logs in or the user edits this, the first name is changed.
  static void setFirstName(String firstname) {
    set(FIRSTNAME, firstname);
  }

  static String getLastName() {
    return get(LASTNAME);
  }

  /// If a different user logs in or the user edits this, the last name is changed.
  static void setLastName(String lastname) {
    set(LASTNAME, lastname);
  }

  static String getEmail() {
    return get(EMAIL);
  }

  /// If a different user logs in or the user edits this, the email is changed.
  static void setEmail(String email) {
    set(EMAIL, email);
  }

  static String getDescription() {
    return get(DESCRIPTION);
  }

  /// If a different user logs in or the user edits this, the user description is changed.
  static void setDescription(String description) {
    set(DESCRIPTION, description);
  }

  static String getProfilePic() {
    return get(PROFILEPIC);
  }

  static void setProfilePic(String url) {
    set(PROFILEPIC, url);
  }

  static int getId() {
    return get(ID);
  }

  static void setId(int id) {
    set(ID, id);
  }

  static void fromJson(Map<String, dynamic> json) {
    setId(json['pk'] as int);
    setFirstName(json['fields']['first_name']);
    setLastName(json['fields']['last_name']);
    setUserName(json['fields']['user_name']);
    setEmail(json['fields']['email_address']);
    setDescription(json['fields']['description']);
  }
}
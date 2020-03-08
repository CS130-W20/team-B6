import 'package:http/http.dart' as http;
import 'package:outlook/managers/firebase_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlook/states/auth_state.dart';

// ApiManager and StorageManager in one
// Checks if certain data exists in storage before calling api for it
class DataManager {

  static const String DOMAIN = 'http://3dbccfc1.ngrok.io';
  static const String AUTH_BOX = "auth";
  static const String USER_BOX = "user";

  static getWithOptions(String url) {
    return http.get(url, headers: {
      "Authorization": "Token ${AuthState.getToken() != null ? AuthState.getToken() : ''}"
    });
  }

  static login(String username, String password) {
    return http.post('$DOMAIN/login', body: {
      "username": username,
      "password": password
    });
  }

  static getUserData(int userId) {
    return getWithOptions('$DOMAIN/users/$userId');
  }

  static getProfilePicture(String username) {
    return FirebaseManager.getProfilePicture(username);
  }
}
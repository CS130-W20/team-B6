import 'package:http/http.dart' as http;
import 'package:outlook/managers/firebase_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ApiManager and StorageManager in one
// Checks if certain data exists in storage before calling api for it
class DataManager {

  static const String DOMAIN = 'BACKEND API URL HERE';
  static const String AUTH_BOX = "auth";
  static const String USER_BOX = "user";

  static getWithOptions(String url) {
    return http.get(url);
  }

  static getUserData(int userId) {
    return getWithOptions('$DOMAIN/users/$userId');
  }

  static getProfilePicture(String username) {
    return FirebaseManager.getProfilePicture(username);
  }
}
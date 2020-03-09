import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outlook/managers/firebase_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlook/states/auth_state.dart';
import 'package:outlook/states/user_state.dart';

// ApiManager and StorageManager in one
// Checks if certain data exists in storage before calling api for it
class DataManager {

  static const String DOMAIN = 'http://ce2280dd.ngrok.io';
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

  static putUserData(String data) {
    return http.put('$DOMAIN/users/put/${UserState.getId()}', headers: {
      "Authorization": "Token ${AuthState.getToken() != null ? AuthState.getToken() : ''}",
    }, body: data);
  }

  static postComment(int postId, String claim, String argument, bool agree, {int parentId = -1}) async {
    var body = {
      "username": UserState.getUserName(),
      "claim": claim,
      "argument": argument,
      "is_agreement": agree ? "True" : "False"
    };
    if(parentId != -1)
      body.putIfAbsent("parent_comment_id", () => parentId.toString());
    return await http.post('$DOMAIN/comments/add/$postId', headers: {
      "Authorization": "Token ${AuthState.getToken() != null ? AuthState.getToken() : ''}",
    }, body: jsonEncode(body));
  }
}
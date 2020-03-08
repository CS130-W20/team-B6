import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlook/managers/data_manager.dart';

class AuthState {

  static getListenable() {
    return Hive.box(DataManager.AUTH_BOX).listenable();
  }

  static void set(String key, var value) {
    var authBox = Hive.box(DataManager.AUTH_BOX);
    authBox.put(key, value);
  }

  static get(String key) {
    var authBox = Hive.box(DataManager.AUTH_BOX);
    return authBox.get(key);
  }

  static String getToken() {
    return get('token');
  }

  static void setToken(String token) {
    set('token', token);
  }

  static String getPassword() {
    return get('password');
  }

  static void setPassword(String password) {
    set('password', password);
  }

}
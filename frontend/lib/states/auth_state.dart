import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthState {

  static const String AUTH_BOX = "auth";

  static getListenable() {
    return Hive.box(AuthState.AUTH_BOX).listenable();
  }

  static void set(String key, var value) {
    var authBox = Hive.box(AuthState.AUTH_BOX);
    authBox.put(key, value);
  }

  static get(String key, { defaultValue: '' }) {
    var authBox = Hive.box(AuthState.AUTH_BOX);
    return authBox.get(key, defaultValue: defaultValue);
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
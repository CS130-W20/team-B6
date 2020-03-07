import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseManager {
  static FirebaseStorage _storage = null;

  static initStorage() async {
    if (_storage == null) {
      final FirebaseApp app = await FirebaseApp.configure(
        name: 'Outlook',
        options: FirebaseOptions(
          googleAppID: Platform.isIOS
              ? '1:448604861097:ios:bbbc62621f025afe5f2fb8'
              : '1:448604861097:android:58853d547b69d36b5f2fb8',
          gcmSenderID: '448604861097',
          apiKey: 'AIzaSyBAcu-7eYDwVX_9w7cKTClyvWRbdQ4oojI',
          projectID: 'outlook-e8e79',
        ),
      );
      FirebaseManager._storage = FirebaseStorage(
          app: app, storageBucket: 'gs://outlook-e8e79.appspot.com/');
    }
  }

  static FirebaseStorage getInstance() {
    return _storage;
  }

  static Future<String> getProfilePicture(String username) async {
    final ref = _storage.ref().child("propic_${username}.jpg");
    String url;
    try {
      url = await ref.getDownloadURL();
    } catch (e) {
      url = "";
    }
    print(url);
    return url;
  }
}
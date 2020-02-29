import 'package:flutter/material.dart';
import 'package:outlook/profile/edit/edit_form.dart';

/// Root of the page that contains a form for the user to edit profile info.
class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key key}): super(key: key);

  final String name = "Edit Profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
              color: Colors.black
          ),
        ),
        body: EditProfileForm(),
    );
  }
}
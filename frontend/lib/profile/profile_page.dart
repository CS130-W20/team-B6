import 'package:flutter/material.dart';
import 'package:outlook/firebase_manager.dart';
import 'package:outlook/profile/cover.dart';
import 'package:outlook/profile/edit_profile_page.dart';
import 'package:outlook/profile/section-control/section_control.dart';
import 'package:outlook/user_state.dart';
import 'package:provider/provider.dart';

/// The profile page has some options in its app bar, like an icon that leads to editing the profile page.
List<Widget> getProfileActions(BuildContext context) {
  return <Widget>[
    IconButton(
      icon: Icon(Icons.mode_edit),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
      },
    )
  ];
}

/// Root of the profile page.
class ProfilePage extends StatefulWidget {

  final String name = "Your Profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, userState, child) {
        return Column(
            children: <Widget>[
              Cover(firstname: userState.firstname, lastname: userState.lastname, username: userState.username),
              Flexible(
                  child: SectionControl()
              )
            ]
        );
      }
    );
  }
}
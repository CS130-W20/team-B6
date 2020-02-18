import 'package:flutter/material.dart';
import 'package:outlook/profile/cover.dart';
import 'package:outlook/profile/edit_profile_page.dart';
import 'package:outlook/profile/section-control/section_control.dart';
import 'package:outlook/user_state.dart';
import 'package:provider/provider.dart';

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
              Cover(name: userState.name, username: userState.username),
              Flexible(
                  child: SectionControl()
              )
            ]
        );
      }
    );
  }
}
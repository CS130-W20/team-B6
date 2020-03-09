import 'package:flutter/material.dart';
import 'package:outlook/profile/cover.dart';
import 'package:outlook/profile/edit_profile_page.dart';
import 'package:outlook/profile/section-control/section_control.dart';
import 'package:outlook/states/user_state.dart';
import 'package:hive/hive.dart';
import 'package:outlook/states/auth_state.dart';
import 'package:outlook/main.dart';

/// The profile page has some options in its app bar, like an icon that leads to editing the profile page.
List<Widget> getProfileActions(BuildContext context) {

  void choiceAction(String action) async {
    switch(action) {
      case 'signout': {
        await Hive.box(AuthState.AUTH_BOX).clear();
        await Hive.box(UserState.USER_BOX).clear();
        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Outlook()));
      }
    }
  }

  return <Widget>[
    IconButton(
      icon: Icon(Icons.mode_edit),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
      },
    ),
    PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'signout',
          child: Text('Sign Out')
        )
      ],
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
    return ValueListenableBuilder(
      valueListenable: UserState.getListenable(),
      builder: (context, userBox, child) {
        UserState userState = UserState.getState();
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
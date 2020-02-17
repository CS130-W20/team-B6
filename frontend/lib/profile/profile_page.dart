import 'package:flutter/material.dart';
import 'package:outlook/profile/cover.dart';
import 'package:outlook/profile/edit_profile_page.dart';
import 'package:outlook/profile/section-control/section_control.dart';
import 'package:outlook/user_state.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}): super(key: key);

  final String name = "Your Profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, userState, child) {
        return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.mode_edit),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                  },
                )
              ],
              iconTheme: IconThemeData(
                  color: Colors.black
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Column(
                children: <Widget>[
                  Cover(name: userState.name, username: userState.username),
                  Flexible(
                      child: SectionControl()
                  )
                ]
            )
        );
      }
    );
  }
}
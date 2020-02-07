import 'package:flutter/material.dart';
import 'package:flutter_app/profile/cover.dart';
import 'package:flutter_app/profile/section-control/sectionControl.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}): super(key: key);

  final String name = "Profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.name),
          backgroundColor: Color(0),
        ),
        body: Column(
          children: <Widget>[
            Cover(name: 'Clayton Chu', username: 'clayton'),
            SectionControl()
          ]
        )
    );
  }
}
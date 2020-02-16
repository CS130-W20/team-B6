import 'package:flutter/material.dart';
import 'dart:math';

class Cover extends StatefulWidget {
  Cover({Key key, this.name, this.username}): super(key: key);

  final String name;
  final String username;

  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      constraints: BoxConstraints(
        maxHeight: min(MediaQuery.of(context).size.height / 3, 250)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfilePicture(),
            ProfileName(name: widget.name, username: widget.username)
          ]
        )
      )
    );
  }
}

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: 120,
          maxWidth: 120
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          image:  DecorationImage(
              image: AssetImage('assets/defaultprofilepic.jpg')
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 8
            )
          ]
      ),
    );
  }
}

class ProfileName extends StatelessWidget {
  ProfileName({Key key, this.name, this.username}): super(key: key);

  final String name;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            Text(name, style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w800
            )),
            Text('@'+username, style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ))
          ],
        )
    );
  }
}
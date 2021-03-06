import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outlook/managers/api_manager.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:outlook/states/user_state.dart';
import 'package:hive/hive.dart';

/// Renders the user's profile picture, name, username, and optionally, a cover photo.
class Cover extends StatefulWidget {
  Cover({Key key, this.userData}): super(key: key);

  final userData;

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
            ProfilePicture(userData: widget.userData),
            ProfileName(name: "${widget.userData['firstname']} ${widget.userData['lastname']}", username: widget.userData['username'])
          ]
        )
      )
    );
  }
}

class ProfilePicture extends StatelessWidget {
  ProfilePicture({Key key, this.userData}): super(key: key);

  final userData;

  Widget buildChild(String profilepic) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: 120,
          maxWidth: 120
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          image:  DecorationImage(
              image: profilepic.length > 0 ? CachedNetworkImageProvider(profilepic) : AssetImage('assets/defaultprofilepic.jpg')
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

  @override
  Widget build(BuildContext context) {
    if (userData['id'] == UserState.getId()) {
      return ValueListenableBuilder(
          valueListenable: UserState.getListenable(),
          builder: (context, userBox, child) {
            UserState userState = UserState.getState();
            return FutureBuilder(
              future: ApiManager.getProfilePicture(userState.username),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != UserState.getProfilePic()) {
                    UserState.setProfilePic(snapshot.data);
                  }
                }
                return buildChild(userState.profilepic);
              },
            );
          }
      );
    }
    return FutureBuilder(
      future: ApiManager.getProfilePicture(userData['username']),
      builder: (context, snapshot) {
        String profilepic = '';
        if (snapshot.hasData) {
          profilepic = snapshot.data;
        }
        return buildChild(profilepic);
      },
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
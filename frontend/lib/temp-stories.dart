import 'package:flutter/material.dart';

import 'newsfeed_body.dart';

class AppHome extends StatelessWidget {

  // final topBar = new AppBar(
  //   backgroundColor: new Color(0xfff8faf8),
  //   centerTitle: true,
  //   elevation: 5.0,
  //   leading: new Icon(Icons.camera_alt),
  //   title: SizedBox(
  //       height: 15.0, child: Image.asset("assets/defaultprofilepic.png")),
  //   actions: <Widget>[
  //     Padding(
  //       padding: const EdgeInsets.only(right: 12.0),
  //       child: Icon(Icons.send),
  //     )
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: topBar,
        body: new NewsfeedBody()
    );
  }
}
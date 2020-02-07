import 'package:flutter/material.dart';

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
      color: Color.fromRGBO(0, 0, 0, 0.2),
      constraints: BoxConstraints(
        maxHeight: 250
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
          maxHeight: 150,
          maxWidth: 150
      ),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white,
              width: 5
          ),
          color: Colors.white,
          image:  DecorationImage(
              image: AssetImage('assets/defaultprofilepic.jpg')
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 20
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
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            Text(name, style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text('@'+username, style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ))
            )
          ],
        )
    );
  }
}
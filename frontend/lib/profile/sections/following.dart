import 'package:flutter/material.dart';

const int GRID_PADDING = 15;
const int ITEMS_PER_ROW = 4;

class FollowingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisCount: ITEMS_PER_ROW,
        childAspectRatio: 0.8,
        children: <Widget>[
          FollowingProfileIcon(name: "John Smith"),
          FollowingProfileIcon(name: "Jack Smith"),
          FollowingProfileIcon(name: "Jake Smith with long name"),
          FollowingProfileIcon(name: "James Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
          FollowingProfileIcon(name: "Jill Smith"),
        ],
    );
  }
}

class FollowingProfileIcon extends StatelessWidget {
  FollowingProfileIcon({Key key, this.name}): super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    int picLen = (MediaQuery.of(context).size.width ~/ ITEMS_PER_ROW) - GRID_PADDING;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 7),
          child: Container(
            width: picLen.toDouble() - 10,
            height: picLen.toDouble() - 10,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/defaultprofilepic.jpg')),
                borderRadius: BorderRadius.all(Radius.circular(100))
            ),
          )
        ),
        Text(name, overflow: TextOverflow.ellipsis)
      ],
    );
  }
}
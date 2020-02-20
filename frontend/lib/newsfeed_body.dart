import 'package:flutter/material.dart';
import 'package:outlook/feed-list.dart';

class NewsfeedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(child: FeedList())
      ],
    );
  }
}
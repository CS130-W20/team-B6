import 'package:flutter/material.dart';
import 'package:outlook/feed-stories.dart';

class FeedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sizeOfDevice = MediaQuery.of(context).size;
    return new ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => index == 0 ? new SizedBox(
          child: new FeedStories(),
          height: sizeOfDevice.height * 0.14,
        ) : Column(),
    );
  }
}
import 'package:flutter/material.dart';
import 'news_story.dart';

class Post extends StatefulWidget {
  // This will be implemented differently once news_story establishes a format
  // to store news article URL, image, and caption.
  // final StoryItem storyItem;

  final String urltempnews;
  final ImageProvider image;
  final String summary;

  Post(this.urltempnews, this.image, this.summary);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  @override
  Widget build(BuildContext context) {

    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [Image(
                image: widget.image,
              )]
            )
          ]
        )
    );
  }
}
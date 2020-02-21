import 'package:flutter/material.dart';
import 'news_story.dart';

class Post extends StatefulWidget {
  // This will be implemented differently once news_story establishes a format
  // to store news article URL, image, and caption.
  // final StoryItem storyItem;

  final String urltempnews;
  final ImageProvider image;
  final String summary;
  final String argument;

  Post(this.urltempnews, this.image, this.summary, this.argument);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool commentsOpened = false;

  @override
  Widget build(BuildContext context) {
    FlatButton commentsButton = FlatButton(
      onPressed: () {setState(() {commentsOpened ^= true;});},
      child: Text("---view replies---",
          style: TextStyle(color: Colors.grey, fontSize: 8),
          textAlign: TextAlign.center)
    );
    Column commentsSection = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Text("Comments:",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text("No comments yet. Weigh in yourself!")
    ]);
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ListView(children: [
          Image(image: widget.image, fit: BoxFit.cover),
          Text("TLDR:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(widget.summary),
          Text("Discuss:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(widget.argument),
          commentsOpened ? commentsSection : SizedBox.shrink(),
          commentsButton
        ]));
  }
}



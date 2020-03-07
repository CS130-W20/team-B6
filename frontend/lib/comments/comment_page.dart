import 'package:flutter/material.dart';
import 'package:outlook/comments/comment.dart';

class CommentPage extends StatelessWidget {
  final Comment comment;
  final String name = "Comment";

  CommentPage(this.comment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: comment.getWidget()
    );
  }
}
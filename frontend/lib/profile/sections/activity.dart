import 'package:flutter/material.dart';

/// Displays the recent comments/posts the user has made.
class ActivitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0.01),
      child: ListView(
          children: <Widget>[
            Comment(
                text: 'Well I\'m just trying to see what other crazy things Florida man will do',
                preview: 'reply to @other_user',
                type: 'reply',
                articleName: 'Florida Man does Something Crazy...Again'
            ),
            Comment(
                text: 'Another sample comment to see what will happen',
                preview: 'reply to @other_user2',
                type: 'reply',
                articleName: 'Some Random Event Happened'
            ),
            Comment(
                text: 'Another sample comment to see what will happen',
                preview: 'reply to @other_user2',
                type: 'reply',
                articleName: 'Some Random Event Happened'
            ),
            Comment(
                text: 'Another sample comment to see what will happen',
                preview: 'reply to @other_user2',
                type: 'reply',
                articleName: 'Some Random Event Happened'
            ),
            Comment(
                text: 'Another sample comment to see what will happen',
                preview: 'reply to @other_user2',
                type: 'reply',
                articleName: 'Some Random Event Happened'
            )
          ]
      )
    );
  }
}

/// Displays one block of activity, with which article it was on and what the user said.
class Comment extends StatefulWidget {

  final String text;
  final String preview;
  final String type;
  final String articleName;

  Comment({Key key, this.text, this.preview, this.type, this.articleName}): super(key: key);

  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(2, 2)
                  )
                ]
            ),
            child: Padding(
                padding: EdgeInsets.all(7),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text(widget.articleName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(widget.preview, style: TextStyle(fontSize: 12)),
                      ),
                      Text(widget.text, style: TextStyle(fontSize: 14))
                    ]
                )
            )
        )
    );
  }
}
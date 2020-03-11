import 'package:flutter/material.dart';
import 'package:outlook/states/user_state.dart';
import 'package:outlook/managers/api_manager.dart';
import 'dart:convert';
import 'dart:core';

/// Displays the recent comments/posts the user has made.
class ActivitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(0, 0, 0, 0.01),
        child: FutureBuilder(
            future: ApiManager.getCommentsFromUser(UserState.getId()),
            builder: (context, snapshot) {
              Widget errorMsg = Center(
                child: Text('Error in retrieving comments.')
              );
              if (snapshot.hasData) {
                try {
                  var commentsResponse = snapshot.data;
                  var commentList = jsonDecode(commentsResponse.body);
                  if (commentsResponse.statusCode == 200) {
                    return ListView(
                        children: <Widget>[
                          for (var comment in commentList) Comment(
                              text: comment['fields']['argument'],
                              preview: comment['fields']['claim'],
                              articleName: comment['fields']['parent_article_title'],
                              type: comment['fields']['parent_comment'] == null ? 'start' : 'reply'
                          )
                        ]
                    );
                  } else {
                    return errorMsg;
                  }
                } catch (e) {
                  return errorMsg;
                }
              } else {
                return Center(
                    child: SizedBox(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                        height: 50,
                        width: 50
                    )
                );
              }
            }
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
                      Divider(color: Colors.blueAccent),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(widget.preview, style: TextStyle(fontSize: 14)),
                      ),
                      Text(widget.text, style: TextStyle(fontSize: 12))
                    ]
                )
            )
        )
    );
  }
}
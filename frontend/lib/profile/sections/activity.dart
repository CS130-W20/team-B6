import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outlook/states/user_state.dart';
import 'package:outlook/managers/api_manager.dart';
import 'dart:convert';
import 'dart:core';
import 'package:outlook/comments/comment.dart';
import 'package:outlook/states/user_state.dart';

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
                child: Text('Error retrieving comments.')
              );
              if (snapshot.hasData) {
                try {
                  var commentsResponse = snapshot.data;
                  if (commentsResponse.statusCode == 200) {
                    var commentList = jsonDecode(commentsResponse.body);
                    if (commentList.length > 0) {
                      return ListView(
                          children: <Widget>[
                            for (var comment in commentList) ActivityComment(
                                text: comment['fields']['argument'],
                                preview: comment['fields']['claim'],
                                articleName: comment['fields']['parent_article_title'],
                                type: comment['fields']['parent_comment'] == null ? 'start' : 'reply',
                                agree: comment['fields']['is_agreement'],
                                isReply: comment['fields']['parent_comment'] != null,
                                replyToUser: comment['fields']['parent_comment_user'],
                                parentComment: comment['fields']['parent_comment'],
                                parentPost: comment['fields']['parent_post']
                            )
                          ]
                      );
                    } else {
                      return Center(
                        child: Text("You haven't commented on anything yet!")
                      );
                    }
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
class ActivityComment extends StatefulWidget {

  final String text;
  final String preview;
  final String type;
  final String articleName;
  final bool agree;
  final bool isReply;
  final String replyToUser; //another user
  final int parentComment; // id
  final int parentPost; // id

  ActivityComment({
    Key key,
    this.text,
    this.preview,
    this.type,
    this.articleName,
    this.agree,
    this.isReply,
    this.replyToUser,
    this.parentComment,
    this.parentPost
  }): super(key: key);

  _CommentState createState() => _CommentState();
}

class _CommentState extends State<ActivityComment> {

  bool notNull(Object o) => o != null;

  void onTap(BuildContext context) {
    var comment = Comment(
      widget.parentPost,
      widget.preview,
      widget.text,
      UserState.getProfilePic() == null ? AssetImage('defaultprofilepic.jpg') : CachedNetworkImageProvider(UserState.getProfilePic()),
      UserState.getUserName(),
      agree: widget.agree,
      parentId: widget.parentComment
    );

    Navigator.push(context, MaterialPageRoute(builder: (_) => comment.getPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => onTap(context),
        child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8),
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
                      widget.isReply ? Text(
                          'reply to @${widget.replyToUser}',
                          style: TextStyle(fontSize: 11)
                      ) : null,
                      Padding(
                    padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                            widget.articleName,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                      Divider(color: Colors.blueAccent),
                      Padding(
                        padding: EdgeInsets.only(top: 3, bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: widget.agree ? Icon(
                                          Icons.thumb_up,
                                          color: Colors.green,
                                          size: 15
                                      ) : Icon(
                                          Icons.thumb_down,
                                          color: Colors.red,
                                          size: 15
                                      )
                                  )
                              ),
                              TextSpan(
                                  text: widget.preview,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: 'Martel'
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                          widget.text,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis
                      )
                    ].where(notNull).toList()
                )
            )
        )
      )
    );
  }
}
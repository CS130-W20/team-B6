import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outlook/comments/comment.dart';
import 'package:outlook/states/user_state.dart';

// The Reply widget is used to show existing replies or to let the user write one.
class Reply extends StatefulWidget {
  final Comment comment;

  Reply(this.comment);

  @override
  State<StatefulWidget> createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  bool posting = false;
  bool agreeing = true;

  @override
  Widget build(BuildContext context) {
    if (posting) {
      final claimController = TextEditingController();
      final argumentController = TextEditingController();
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(
          controller: claimController,
          decoration: new InputDecoration(
            //border: InputBorder.none,
            hintText: "Claim",
          ),
        ),
        TextField(
          controller: argumentController,
          decoration: new InputDecoration(
            //border: InputBorder.none,
            hintText: "Argument",
          ),
        ),
        Row(children: [
          RaisedButton(
            child: Text(agreeing ? "Agree" : "Dissent"),
            onPressed: () {
              if (claimController.text.isNotEmpty &&
                  argumentController.text.isNotEmpty) {
                setState(() {
                  posting = false;
                  final replyList = agreeing
                      ? widget.comment.agrees
                      : widget.comment.dissents;
                  final userState = UserState.getState();
                  replyList.add(Comment.postComment(
                      widget.comment.postId,
                      claimController.text,
                      argumentController.text,
                      userState.profilepic.length > 0
                          ? CachedNetworkImageProvider(userState.profilepic)
                          : AssetImage('assets/defaultprofilepic.jpg'),
                      "${userState.firstname} ${userState.lastname}",
                      agree: agreeing,
                      parentId: widget.comment.commentId));
                });
              }
            },
          ),
          SizedBox(width: 16),
          RaisedButton(
            child: Text("Cancel"),
            onPressed: () {
              setState(() {
                posting = false;
              });
            },
          ),
        ]),
      ]);
    } else {
      return FutureBuilder<void>(
          future: widget.comment.repliesFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) return Text("loading");
            print('done waiting for replies');
            Column agreeList = Column(
              children: widget.comment.agrees.map((c) => c.getPreview()).toList());
            Column dissentList = Column(
              children:
              widget.comment.dissents.map((c) => c.getPreview()).toList());
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: RaisedButton(
                            color: Color.fromRGBO(0, 150, 0, 0.4),
                            child: Text("Agree",
                                style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () {
                              setState(() {
                                posting = true;
                                agreeing = true;
                              });
                            }),
                        ),
                    agreeList,
                  ])),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: RaisedButton(
                              color: Color.fromRGBO(255, 0, 0, 0.4),
                              child: Text("Dissent",
                                  style: TextStyle(color: Colors.white, fontSize: 12)),
                              onPressed: () {
                                setState(() {
                                  posting = true;
                                  agreeing = false;
                                });
                              }),
                        ),
                    dissentList,
                  ]))
            ]);
          });
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outlook/comments/comment.dart';
import 'package:outlook/states/user_state.dart';
import 'package:provider/provider.dart';

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
          Consumer<UserState>(builder: (context, userState, child) => RaisedButton(
            child: Text(agreeing ? "Agree" : "Dissent"),
            onPressed: () {
              if (claimController.text.isNotEmpty &&
                argumentController.text.isNotEmpty) {
                setState(() {
                  posting = false;
                  final replyList = agreeing
                    ? widget.comment.agrees
                    : widget.comment.dissents;
                  replyList.add(Comment(
                    claimController.text,
                    argumentController.text,
                    userState.profilepic.length > 0 ? CachedNetworkImageProvider(userState.profilepic) : AssetImage('assets/defaultprofilepic.jpg'),
                    "${userState.firstname} ${userState.lastname}"));
                });
              }
            },
          )),
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
      Column agreeList = Column(
          children: widget.comment.agrees.map((c) => c.getPreview()).toList());
      Column dissentList = Column(
          children:
              widget.comment.dissents.map((c) => c.getPreview()).toList());
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RaisedButton(
              child: Text("Agree",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              onPressed: () {
                setState(() {
                  posting = true;
                  agreeing = true;
                });
              }),
          agreeList,
        ])),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RaisedButton(
              child: Text("Dissent",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              onPressed: () {
                setState(() {
                  posting = true;
                  agreeing = false;
                });
              }),
          dissentList,
        ]))
      ]);
    }
  }
}

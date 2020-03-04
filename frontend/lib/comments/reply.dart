import 'package:flutter/material.dart';
import 'package:outlook/comments/comment.dart';

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
            child: Text("Post"),
            onPressed: () {
              if (claimController.text.isNotEmpty && argumentController.text.isNotEmpty) {
                setState(() {
                  posting = false;
                  final replyList = agreeing ? widget.comment.agrees : widget.comment.dissents;
                  replyList.add(Comment(
                      claimController.text,
                      argumentController.text,
                      AssetImage('assets/defaultprofilepic.jpg'),
                      "PoliticsAreFake2"));
                });
              }
            },
          ),
          SizedBox(width:16),
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

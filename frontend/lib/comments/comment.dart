import 'package:flutter/material.dart';
import 'package:outlook/comments/comment_page.dart';
import 'package:outlook/comments/reply.dart';

// Contains the commenter's info, their comment, and replies.
// This class has three singleton Widget member variables to be displayed: the
// preview, the comment, and the page containing the comment.
class Comment {
  final String claim;
  final String argument;
  final ImageProvider commenterPic;
  final String commenterName;
  List<Comment> agrees = List<Comment>();
  List<Comment> dissents = List<Comment>();
  CommentPreview preview;
  CommentWidget widget;
  CommentPage page;

  Comment(this.claim, this.argument, this.commenterPic, this.commenterName);

  CommentPreview getPreview() {
    if (preview == null) {
      preview = CommentPreview(this);
    }
    return preview;
  }

  CommentWidget getWidget() {
    if (widget == null) {
      widget = CommentWidget(this);
    }
    return widget;
  }

  CommentPage getPage() {
    if (page == null) {
      page = CommentPage(this);
    }
    return page;
  }
}

// CommentPreviews are displayed below newsfeed items and as replies to other
// comments.
class CommentPreview extends StatelessWidget {
  final Comment comment;

  CommentPreview(this.comment);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => comment.getPage()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: comment.commenterPic),
                  )),
              SizedBox(width: 10),
              Text(comment.commenterName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ]),
            Text(comment.claim, style: TextStyle(fontSize: 14)),
          ],
        ));
  }
}

// CommentWidget shows the comment's full argument and is only shown on a CommentPage.
class CommentWidget extends StatefulWidget {
  final Comment comment;
  final Reply reply;

  CommentWidget(this.comment): reply = Reply(comment);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
            child: ListView(children: [
              Text("Claim", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.comment.claim, style: TextStyle(fontSize: 18)),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: widget.comment.commenterPic))),
                SizedBox(width: 10),
                Text(widget.comment.commenterName,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ]),
              Text("Argument:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.comment.argument, style: TextStyle(fontSize: 14)),
              Divider(),
              widget.reply
            ])
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:outlook/comments/comment_page.dart';

List<Widget> getCommentActions(BuildContext context) {
  return <Widget>[
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    )
  ];
}

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
      CommentWidget(this);
    }
    return widget;
  }

  CommentPage getPage() {
    if (page == null) {
      CommentPage(this);
    }
    return page;
  }
}

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

class CommentWidget extends StatefulWidget {
  final Comment comment;

  CommentWidget(this.comment);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    Column agreeList = Column(
      children: widget.comment.agrees.map((c) => c.getPreview()).toList()
    );
    Column dissentList = Column(
        children: widget.comment.dissents.map((c) => c.getPreview()).toList()
    );
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
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Agree",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  RaisedButton(onPressed: () {
                    setState(() {
                      widget.comment.agrees.add(Comment(
                        "Yeah same",
                          "I agree with that",
                          AssetImage('assets/defaultprofilepic.jpg'),
                          "PoliticsAreFake2"
                      ));
                    });
                  }),
                  agreeList,
                ])),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Dissent",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  RaisedButton(onPressed: () {
                    setState(() {
                      widget.comment.dissents.add(Comment(
                          "No that's wrong",
                          "This will prove it",
                          AssetImage('assets/defaultprofilepic.jpg'),
                          "guy"
                      ));
                    });
                  }),
                  dissentList,
                ]))
              ]),
            ])
        )
    );
  }
}

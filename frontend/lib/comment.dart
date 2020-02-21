import 'package:flutter/material.dart';
import 'package:outlook/user_state.dart';

class Comment extends StatefulWidget {
  final String claim;
  final String argument;
  final ImageProvider commenterPic;
  final String commenterName;

  Comment(this.claim, this.argument, this.commenterPic, this.commenterName);

  @override
  _CommentState createState() => _CommentState();

  commentPreview(BuildContext context) => InkWell(
    onTap: () {
      print("context: " + context.toString());
      print(this.toString());
      // TODO(Jeffrey): figure out how to get this material info directly rather than hard coding it.
      Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Martel'
        ),
        home: Material(child: this),
      )));
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
                    fit: BoxFit.fill,
                    image: commenterPic),
              )),
          SizedBox(width: 10),
          Text(commenterName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ]),
        Text(claim, style: TextStyle(fontSize: 14)),
      ],
    )
  );
}

class _CommentState extends State<Comment> {

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(children: [
          Text("Claim", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(widget.claim, style: TextStyle(fontSize: 18)),
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: widget.commenterPic)
                )),
            SizedBox(width: 10),
            Text(widget.commenterName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ]),
          Text("Argument:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(widget.argument, style: TextStyle(fontSize: 14)),
          Text("Reply", style: TextStyle(color: Colors.grey, fontSize: 12))
        ]));
  }
}

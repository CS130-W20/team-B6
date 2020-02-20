import 'package:flutter/material.dart';

class FeedStories extends StatelessWidget {

  final topText = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget> [
      Text(
        "Stories",
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      new Row(
        children: <Widget>[
          //new Icon(Icon.play_arrow),
          new Text("Watch All", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      )
    ]
  );
  final stories = Expanded (
    child: new Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index)=> new Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              new Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage("https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")
                  )
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              )
            ],
        ),
      ),
    )
  );
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          topText,
          stories,
        ],
      )
      
    );
  }
}
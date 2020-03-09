import 'package:flutter/material.dart';
import 'story_main.dart';

class FeedStories extends StatelessWidget {

  // BuildContext context;

  final topText = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget> [
      Text(
        "Latest News",
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      
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
                child: InkWell(
                onTap: () => getNewsStory(context,'datapass'),
                child: Container(
                width: 70.0,
                height: 200.0,
                decoration: new BoxDecoration(
                  border: Border.all(width: 3.0,color: Colors.black),
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage("https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/082012/bbc_news.png?itok=wf2PsHXO")
                  )
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                ),
              ),
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
          new Container(
                child: InkWell(
                onTap: () => getNewsStory(context,'datapass'),
                child: Container(
          topText,
          stories,
                ),
                ),
                ),
        ],
      )
      
    );
  }
}
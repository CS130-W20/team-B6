import 'package:flutter/material.dart';




class FeedStories extends StatelessWidget {
  static Container MyArticles(String url) {
      return Container(
                width: 70.0,
                height: 200.0,
                decoration: new BoxDecoration(
                  border: Border.all(width: 3.0,color: Colors.black),
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(url),
                  )
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              );
    }

  final topText = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget> [
      Text(
        "Latest News",
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
      child: new ListView(
        scrollDirection: Axis.horizontal,
        // itemCount: 2,
        // itemBuilder: (context, index)=> new Stack(
            // alignment: Alignment.bottomRight,
            children: <Widget>[
              MyArticles("https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/082012/bbc_news.png?itok=wf2PsHXO"),
              MyArticles("https://cdn.cnn.com/cnn/.e1mo/img/4.0/logos/CNN_logo_400x400.png"),
              MyArticles("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSzsscufXOmVBrgtovLWCQaIsNLA118UpUFIWIUmZuRyJxWhfud"),
              MyArticles("https://apprecs.org/gp/images/app-icons/300/bd/com.toi.reader.activities.jpg"),
              MyArticles("https://media.glassdoor.com/sqll/104032/techcrunch-squarelogo-1513591957398.png"),
              MyArticles("https://lh3.googleusercontent.com/proxy/FBojPBku0rEr0nWFXSTqWnsNNu7LT_0WeSlfXl902ZJ5e9jwENRYy8-iC6vS9jhLDd3PPBR1GC5ZHvFeq7agEIdazaTuoyWPlGabZ4wIixGmU_1lvc7YDZTyCJdqjuEtA3qkOn9zZfrVU-KBoQk4noErh6MjHdCi7rKtiP6px1bDWGr8WFwwMnPFRUwzMpJMxu6amV_B7Z3X0DcjfF13lodZvLCVKOlKUv8iu6duWNtH"),
              MyArticles("https://yt3.ggpht.com/a/AGF-l7-wuYtDksmLBwlT5PE9LdMlKt0X2762ynpXLg=s900-c-k-c0xffffffff-no-rj-mo"),
              // new Container(
              //   width: 70.0,
              //   height: 200.0,
              //   decoration: new BoxDecoration(
              //     border: Border.all(width: 3.0,color: Colors.black),
              //     shape: BoxShape.rectangle,
              //     image: new DecorationImage(
              //         fit: BoxFit.fill,
              //         image: new NetworkImage(url_temp),
              //     )
              //   ),
              //   margin: const EdgeInsets.symmetric(horizontal: 8.0),
              // )
            ],
        // ),
        
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
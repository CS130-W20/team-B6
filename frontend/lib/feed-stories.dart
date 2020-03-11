import 'package:flutter/material.dart';
import 'package:outlook/story_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var urlBbc = "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/082012/bbc_news.png?itok=wf2PsHXO";
var urlCnn = "https://cdn.cnn.com/cnn/.e1mo/img/4.0/logos/CNN_logo_400x400.png";
var urlAl = "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSzsscufXOmVBrgtovLWCQaIsNLA118UpUFIWIUmZuRyJxWhfud";
var urlToi = "https://apprecs.org/gp/images/app-icons/300/bd/com.toi.reader.activities.jpg";
var urlTc = "https://media.glassdoor.com/sqll/104032/techcrunch-squarelogo-1513591957398.png";
var urlAbc = "https://yt3.ggpht.com/a/AGF-l7-wuYtDksmLBwlT5PE9LdMlKt0X2762ynpXLg=s900-c-k-c0xffffffff-no-rj-mo";
class FeedStories extends StatelessWidget {
  Future<String> getData(var urlTemp) async {
    var res = await http.get(Uri.encodeFull(urlTemp), headers: {"Authorization": "Token 9b0992c1398d71a14ba9009905deaf2f878c3a09"});
    print(res.body);
    return res.body;
  }
  static GestureDetector myArticles(String url, BuildContext context){
    return GestureDetector(
            onTap: () async {
              var urlPass;
                if (url == urlBbc) {
                  urlPass = "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/bbc-news";
                }
                else if (url == urlCnn) {
                  urlPass = "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/cnn";
                }
                else if (url == urlAl) {
                  urlPass = "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/al-jazeera-english";
                }
                else if (url == urlToi) {
                  urlPass = "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/the-times-of-india";
                }
                else if (url == urlTc) {
                  urlPass = "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/techcrunch";
                }
                else if (url == urlAbc) {
                  urlPass = "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/abc-news";
                }
                var res = await http.get(Uri.encodeFull(urlPass), headers: {"Authorization": "Token 9b0992c1398d71a14ba9009905deaf2f878c3a09"});
                final List<dynamic> data = json.decode(res.body);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsStoryApp(),
                  ),
                );
                print(data[0]["article"]["article_image_url"]);
            },
            child: new SizedBox(
              width: 60,
              height: 100,
              child: new Container(
                width: 70.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(url),
                    )
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              )
            )
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
  
  @override
  Widget build(BuildContext context) {
    final stories = Expanded (
    child: new Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: new ListView(
        scrollDirection: Axis.horizontal,
        // itemCount: 2,
        // itemBuilder: (context, index)=> new Stack(
            // alignment: Alignment.bottomRight,
            children: <Widget>[
              myArticles(urlBbc, context),
              myArticles(urlCnn, context),
              myArticles(urlAl, context),
              myArticles(urlToi, context),
              myArticles(urlTc, context),
              myArticles(urlAbc, context),
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
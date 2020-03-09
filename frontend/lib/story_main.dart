import 'dart:convert';

import 'package:flutter/material.dart';
import 'news_story.dart';
import 'news_story.dart';

import 'package:http/http.dart' as http;

List<String> url_list = ['https://stackoverflow.com/questions/48836636/how-to-use-functions-of-another-file-in-dart-flutter','https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2', 'https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2', 'https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2',''];
List<String> image_list = ['https://i.insider.com/5e3b296be35bab4f171e181b','https://i.insider.com/5e3b296be35bab4f171e181b','https://i.insider.com/5e3b296be35bab4f171e181b','https://i.insider.com/5e3b296be35bab4f171e181b',''];
List<String> title_list = ['There\'s a good chance the Wuhan corona','There\'s a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.', 'There\'s a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.','There\'s a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.',''];
List<int> id_list = [1,2,3,4,5];

var hardcodeCounter = 0;
var sourceMapper = {
  0: 'bbc-news',
  1: 'the-wall-street-journal',
  2: 'bloomberg',
  3: 'the-times-of-india',
  4: 'techcrunch',
  5: 'abc-news',
};

// List<String> url_list = List<String>();
// List<String> image_list = List<String>();
// List<String> title_list = List<String>();
// List<int> id_list = List<int>();

_fetchData(String source_name) async {
    String link =
          "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/" + source_name;
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json", "Authorization": "Token 23142425b8a8185550014d18ff098b4be3242e4b"});
    //print(res.body);
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data as List;
        //print(rest);
        return rest;
      }
}

List<Widget> getNewsStory(BuildContext context, String source_name) {
  print ('--------');
  // Making API Call to backend to get news for source names.
  source_name = sourceMapper[hardcodeCounter];
  hardcodeCounter += 1;
  hardcodeCounter = hardcodeCounter % 5;
  _fetchData(source_name).then((data) {
    print("HERE");
    print(data);
    print(data[0]["article"]["title"]);

    title_list[0] = data[0]["article"]["title"];
    image_list[0] = data[0]["article"]["article_image_url"];
    url_list[0] = data[0]["article"]["article_url"];
    id_list[0] = data[0]["article"]["id"];

    title_list[1] = data[1]["article"]["title"];
    image_list[1] = data[1]["article"]["article_image_url"];
    url_list[1] = data[1]["article"]["article_url"];
    id_list[1] = data[1]["article"]["id"];

    title_list[2] = data[2]["article"]["title"];
    image_list[2] = data[2]["article"]["article_image_url"];
    url_list[2] = data[2]["article"]["article_url"];
    id_list[2] = data[2]["article"]["id"];

    title_list[3] = data[3]["article"]["title"];
    image_list[3] = data[3]["article"]["article_image_url"];
    url_list[3] = data[3]["article"]["article_url"];
    id_list[3] = data[3]["article"]["id"];

    title_list[4] = data[4]["article"]["title"];
    image_list[4] = data[4]["article"]["article_image_url"];
    url_list[4] = data[4]["article"]["article_url"];
    id_list[4] = data[4]["article"]["id"];
});

  return <Widget>[
    IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsStoryApp()),
            );
          },
    )
  ];
  
}

class NewsStoryApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News Stories',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: NewsStory());
  }
}

class NewsStory extends StatefulWidget {
  @override
  _NewsStory createState() => _NewsStory();
}

class _NewsStory extends State<NewsStory> {
  final storyController = NewsStoryActions();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }


  List<StoryItem> story_automate() {

      List<StoryItem> story_list = List<StoryItem>();

      for (var i = 0; i < id_list.length; i++) {
            story_list.add(
                StoryItem.inlineImage(
                    url_list[i] ,
                    NetworkImage(
                         image_list[i] ),
                    caption: Text(
                      title_list[i] ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        // backgroundColor: Colors.black54,
                        fontSize: 25,
                        
                      ),
                    ),
                  ),

            ); 
          
          };

      return story_list;

  // print (story_list);

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // final for_loop_newstory = <Widget>[];

      

      

      body: StoryView( story_automate(),
       

      
       
        // [
          
          



          // StoryItem.inlineImage(
          //           "https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2",
          //           NetworkImage(
          //               "https://i.insider.com/5e3b296be35bab4f171e181b"),
          //           caption: Text(
          //             "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.black,
          //               // backgroundColor: Colors.black54,
          //               fontSize: 25,
                        
          //             ),
          //           ),
          //         ),

          // StoryItem.inlineImage(
          //           "https://stackoverflow.com/questions/49991444/create-a-rounded-button-button-with-border-radius-in-flutter",
          //           NetworkImage(
          //               "https://i.insider.com/5e3b296be35bab4f171e181b"),
          //           caption: Text(
          //             "Thereeee's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.black,
          //               // backgroundColor: Colors.black54,
          //               fontSize: 25,
                        
          //             ),
          //           ),
          //         ),


          // StoryItem.inlineImage(
          //           "https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2",
          //           NetworkImage(
          //               "https://i.insider.com/5e3b296be35bab4f171e181b"),
          //           caption: Text(
          //             "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.black,
          //               // backgroundColor: Colors.black54,
          //               fontSize: 25,
                        
          //             ),
          //           ),
          //         ),

          // StoryItem.inlineImage(
          //           "https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2",
          //           NetworkImage(
          //               "https://i.insider.com/5e3b296be35bab4f171e181b"),
          //           caption: Text(
          //             "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.black,
          //               // backgroundColor: Colors.black54,
          //               fontSize: 25,
                        
          //             ),
          //           ),
          //         ),

          // StoryItem.inlineImage(
          //           "https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2",
          //           NetworkImage(
          //               "https://i.insider.com/5e3b296be35bab4f171e181b"),
          //           caption: Text(
          //             "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.black,
          //               // backgroundColor: Colors.black54,
          //               fontSize: 25,
                        
          //             ),
          //           ),
          //         ),




          
          
          
        // ]
        // ,
        onStoryShow: (s) {
          print("Checking a News Story");
        },
        onComplete: () {
          print("Round of News Stories Finished");
        },
        
        progressPosition: ProgressPosition.top,
        repeat: true,
        controller: storyController,
      ),
    );
  }
}
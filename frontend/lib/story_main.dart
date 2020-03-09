import 'package:flutter/material.dart';
import 'news_story.dart';




List<Widget> getNewsStory(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StoryView(
        [
          
          
          StoryItem.inlineImage(
                    "https://www.businessinsider.com/wuhan-coronavirus-mild-pandemic-how-it-could-end-2020-2",
                    NetworkImage(
                        "https://i.insider.com/5e3b296be35bab4f171e181b"),
                    caption: Text(
                      "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        // backgroundColor: Colors.black54,
                        fontSize: 25,
                        
                      ),
                    ),
                  ),

          StoryItem.inlineImage(
                    "https://stackoverflow.com/questions/49991444/create-a-rounded-button-button-with-border-radius-in-flutter",
                    NetworkImage(
                        "https://i.insider.com/5e3b296be35bab4f171e181b"),
                    caption: Text(
                      "Thereeee's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        // backgroundColor: Colors.black54,
                        fontSize: 25,
                        
                      ),
                    ),
                  ),


          StoryItem.inlineImage(
                    "https://www.google.com",
                    NetworkImage(
                        "https://i.insider.com/5e3b296be35bab4f171e181b"),
                    caption: Text(
                      "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        // backgroundColor: Colors.black54,
                        fontSize: 25,
                        
                      ),
                    ),
                  ),

          StoryItem.inlineImage(
                    "https://www.facebook.com",
                    NetworkImage(
                        "https://i.insider.com/5e3b296be35bab4f171e181b"),
                    caption: Text(
                      "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        // backgroundColor: Colors.black54,
                        fontSize: 25,
                        
                      ),
                    ),
                  ),

          StoryItem.inlineImage(
                    "https://www.quora.com",
                    NetworkImage(
                        "https://i.insider.com/5e3b296be35bab4f171e181b"),
                    caption: Text(
                      "There's a good chance the Wuhan coronavirus will never disappear, experts say. There are only 3 possible endings to this story.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        // backgroundColor: Colors.black54,
                        fontSize: 25,
                        
                      ),
                    ),
                  ),




          
          
          
        ],
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
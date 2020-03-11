import 'package:flutter/material.dart';
import 'package:outlook/comments/comment.dart';
import 'package:outlook/feed-stories.dart' show FeedStories;
import 'package:outlook/managers/api_manager.dart';
import 'dart:math';
import 'package:outlook/states/user_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

var fruits = ["https://www.logodesignlove.com/wp-content/uploads/2010/06/cnn-logo-white-on-red.jpg"
, "https://ichef.bbci.co.uk/news/320/cpsprodpb/80F2/production/_111201033_mediaitem111201032.jpg", "https://www.aljazeera.com/mritems/imagecache/mbdxxlarge/mritems/Images/2020/3/9/78b0860c142c46e0a93431eabaedf57d_18.jpg"];
Random rnd = new Random();
var url = fruits[1];
class FeedList extends StatelessWidget {
  /*
  static Comment sampleComment = Comment.postComment(1,
    "Elections are all just made up.",
    "Politics has just stoppped happening, there's no more politics.",
    AssetImage('assets/defaultprofilepic.jpg'),
    "PoliticsAreFake"
  );
  */

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Future<List<Comment>> commentsOnPost1 = ApiManager.getCommentsOnPost(1);
    return FutureBuilder<List<Comment>>(
      future: commentsOnPost1,
      builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
        List<Widget> commentPreviewList;
        if(snapshot.hasData){
          commentPreviewList = snapshot.data.map((c) =>
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 0),
              child: c.getPreview()
            )).toList();
        }
        else {
          commentPreviewList = [Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 0),
            child: Text('loading comments...')
          )];
        }
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => index == 0
            ? new SizedBox(
            child: new FeedStories(),
            height: deviceSize.height * 0.15,
          )
            : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Container(
                          height: 40.0,
                          width: 60.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                "https://www.logodesignlove.com/wp-content/uploads/2010/06/cnn-logo-white-on-red.jpg")),
                          ),
                        ),
                        new SizedBox(
                          width: 10.0,
                        ),
                        new Text(
                          "February 20, 2020",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                    new IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: null,
                    )
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: new Image.network(
                  "https://ichef.bbci.co.uk/news/320/cpsprodpb/80F2/production/_111201033_mediaitem111201032.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new SizedBox(
                          width: 16.0,
                        ),
                        new Icon(Icons.arrow_upward),
                      ],
                    ),
                    new Icon(Icons.announcement)

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "All of Italy is in lockdown as coronavirus cases rise \n Upvoted by 3 others",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),]
            +commentPreviewList
            +[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: UserState.getProfilePic().length > 0 ? CachedNetworkImageProvider(UserState.getProfilePic()) : AssetImage('assets/defaultprofilepic.jpg')),
                      ),
                    ),
                    new SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: new TextField(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Start Debating...",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:
                Text("1 Week Ago", style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        );
      },
    );

  }
}
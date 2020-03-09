import 'package:flutter/material.dart';
import 'package:outlook/comments/comment.dart';
import 'package:outlook/feed-stories.dart' show FeedStories;
import 'package:http/http.dart' as http;

class StoryPostData {
  String url;
  String imageUrl;
  String title;
  int postId;

  StoryPostData({this.url, this.imageUrl, this.title, this.postId});
  
  showUrl() {
    print(url);
  }
  showPostId() {
    print(postId);
  }
  showTitle() {
    print(title);
  }
}


class ExtractData {
  final String url = "https://sheltered-tor-57022.herokuapp.com/newsfeed/source/bbc-news";
  List data;
  Future<String> getData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {"Authorization": "9b0992c1398d71a14ba9009905deaf2f878c3a09"});
    print(res);
    return "Success!";
  }
 }

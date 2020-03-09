import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:outlook/comments/comment.dart';
import 'package:outlook/managers/firebase_manager.dart';
import 'package:outlook/states/auth_state.dart';
import 'package:outlook/states/user_state.dart';

// ApiManager and StorageManager in one
// Checks if certain data exists in storage before calling api for it
class ApiManager {
  static const String DOMAIN = 'http://ce2280dd.ngrok.io';

  /// Generic Api GET function with token
  static getWithOptions(String url) {
    return http.get(url, headers: {
      "Authorization":
          "Token ${AuthState.getToken() != null ? AuthState.getToken() : ''}"
    });
  }

  /// Generic Api PUT function with token
  static putWithOptions(String url, String data) {
    return http.put('$DOMAIN/users/put/${UserState.getId()}',
        headers: {
          "Authorization":
              "Token ${AuthState.getToken() != null ? AuthState.getToken() : ''}",
        },
        body: data);
  }

  /// @params:
  /// data = {
  ///   firstname: String,
  ///   lastname: String,
  ///   username: String,
  ///   password: String
  /// }
  static signup(String data) {
    return http.post('$DOMAIN/signup', body: data);
  }

  static login(String username, String password) {
    return http.post('$DOMAIN/login',
        body: {"username": username, "password": password});
  }

  static getUserData(int userId) {
    return getWithOptions('$DOMAIN/users/$userId');
  }

  static getProfilePicture(String username) {
    return FirebaseManager.getProfilePicture(username);
  }

  static putUserData(String data) {
    return putWithOptions('$DOMAIN/users/put/${UserState.getId()}', data);
  }

  static postComment(int postId, String claim, String argument, bool agree,
      {int parentId = -1}) async {
    var body = {
      "username": UserState.getUserName(),
      "claim": claim,
      "argument": argument,
      "is_agreement": agree ? "True" : "False"
    };
    if (parentId != -1)
      body.putIfAbsent("parent_comment_id", () => parentId.toString());
    return await http.post('$DOMAIN/comments/add/$postId',
        headers: {
          "Authorization":
              "Token ${AuthState.getToken() != null ? AuthState.getToken() : ''}",
        },
        body: jsonEncode(body));
  }

  static Future<List<Comment>> getCommentsOnPost(int postId) async {
    print('getting comments for post $postId');
    http.Response commentsResponse = await getWithOptions('$DOMAIN/comments/$postId');
    List<Comment> comments = [];
    if (commentsResponse.statusCode == 200) {
      final jsonComments = jsonDecode(commentsResponse.body);
      for (var item in jsonComments) {
        // print(item);
        if (item['fields']['parent_comment'] != null) continue;
        final userResponse = await getUserData(item['fields']['user']);
        var commenterName = 'error';
        ImageProvider commenterPic = AssetImage('assets/defaultprofilepic.jpg');
        if (userResponse.statusCode == 200) {
          final user = jsonDecode(userResponse.body);
          commenterName =
          '${user['fields']['first_name']} ${user['fields']['last_name']}';
          String picUrl =
          user['fields']['profile_picture_url'];
          if (picUrl.isNotEmpty)
            commenterPic = CachedNetworkImageProvider(picUrl);
        }
        print('user gotten');
        var newComment = Comment(postId, item['fields']['claim'], item['fields']['argument'],
          commenterPic, commenterName,
          agree: item['fields']['is_agreement']);
        newComment.commentId = item['pk'];
        comments.add(newComment);
      }
    }
    print('comments gotten for post $postId');
    return comments;
  }
  
  static Future<List<List<Comment>>> getReplies(Comment comment) async {
    print('getting replies for comment ${comment.commentId}');
    http.Response repliesResponse = await getWithOptions('$DOMAIN/comments/get_replies/${comment.commentId}');
    List<Comment> agrees = [];
    List<Comment> dissents = [];
    if(repliesResponse.statusCode == 200){
      final jsonReplies = jsonDecode(repliesResponse.body);
      for(var item in jsonReplies){
        // print(item);
        if (item['fields']['parent_comment'] == null) continue;
        final userResponse = await getUserData(item['fields']['user']);
        var commenterName = 'error';
        ImageProvider commenterPic = AssetImage('assets/defaultprofilepic.jpg');
        if (userResponse.statusCode == 200) {
          final user = jsonDecode(userResponse.body);
          commenterName =
          '${user['fields']['first_name']} ${user['fields']['last_name']}';
          String picUrl =
          user['fields']['profile_picture_url'];
          if (picUrl.isNotEmpty)
            commenterPic = CachedNetworkImageProvider(picUrl);
        }
        print('user gotten');
        var newComment = Comment(comment.postId, item['fields']['claim'], item['fields']['argument'],
          commenterPic, commenterName,
          agree: item['fields']['is_agreement'],
        parentId: comment.commentId);
        newComment.commentId = item['pk'];
        if(item['fields']['is_agreement']){
          agrees.add(newComment);
        }
        else {
          dissents.add(newComment);
        }
      }
    }
    print('replies gotten for comment ${comment.commentId}');
    return [agrees, dissents];
  }
}

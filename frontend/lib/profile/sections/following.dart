import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outlook/managers/api_manager.dart';
import 'package:outlook/states/user_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:outlook/profile/profile_page.dart';

const int GRID_PADDING = 15;
const int ITEMS_PER_ROW = 4;

/// Shows the people who the user follows on their profile page.
class FollowingSection extends StatelessWidget {
  FollowingSection({Key key, this.userData}): super(key: key);

  final userData;

  void onPressed(BuildContext context, var following) {
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text('${following['fields']['first_name']} ${following['fields']['last_name']}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )
            ),
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: ProfilePage(userData: {
            "id": following['pk'],
            "firstname": following['fields']['first_name'],
            "lastname": following['fields']['last_name'],
            "username": following['fields']['user_name'],
            "description": following['fields']['description']
          })
        )
    ));
  }

  @override
  Widget build(BuildContext context) {
    print(userData);
    Widget errorMsg = Center(
        child: Text('Error retrieving followers.')
    );
    return FutureBuilder(
      future: ApiManager.getFollowers(userData['id']),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var followingResponse = snapshot.data;
          if (followingResponse.statusCode == 200) {
            var followingList = jsonDecode(followingResponse.body);
            if (followingList.length > 0) {
              return GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: ITEMS_PER_ROW,
                childAspectRatio: 0.8,
                children: <Widget>[
                  for (var following in followingList)
                    FlatButton(
                        onPressed: () => onPressed(context, following),
                        padding: EdgeInsets.all(0),
                        child: FollowingProfileIcon(following: following)
                    )
                ],
              );
            } else {
              return Center(
                  child: Text("Not following anyone yet!")
              );
            }
          } else {
            return errorMsg;
          }
        } else {
          return Center(
              child: SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                  height: 50,
                  width: 50
              )
          );
        }
      }
    );
  }
}

class FollowingProfileIcon extends StatelessWidget {
  FollowingProfileIcon({Key key, this.following}): super(key: key);

  final following;

  @override
  Widget build(BuildContext context) {
    int picLen = (MediaQuery.of(context).size.width ~/ ITEMS_PER_ROW) - GRID_PADDING;

    return FutureBuilder(
      future: ApiManager.getProfilePicture(following['fields']['user_name']),
      builder: (context, snapshot) {
        ImageProvider profilePic = AssetImage('assets/defaultprofilepic.jpg');
        if (snapshot.hasData) {
          profilePic = CachedNetworkImageProvider(snapshot.data);
        }
        return Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 7),
                child: Container(
                  width: picLen.toDouble() - 10,
                  height: picLen.toDouble() - 10,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: profilePic),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Color.fromRGBO(0, 0, 0, 0.1)
                        )
                      ]
                  ),
                )
            ),
            Text('${following['fields']['first_name']} ${following['fields']['last_name']}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12)
            )
          ],
        );
      }
    );
  }
}
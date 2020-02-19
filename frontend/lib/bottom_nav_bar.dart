import 'package:flutter/material.dart';
import 'package:outlook/main.dart';
import 'package:provider/provider.dart';
import 'package:outlook/user_state.dart';
import 'package:outlook/profile/profile_page.dart';
import 'package:outlook/page_state.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key key}): super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
        builder: (context, userState, child) {
          return Consumer<PageState>(
            builder: (context, pageState, child) {

              void _onTap(int index) {
                if (index == pageState.currentIndex) {
                  return;
                }
                pageState.changePage(index);
              }

              return BottomNavigationBar(
                  currentIndex: pageState.currentIndex,
                  onTap: _onTap,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        title: Text('Discover')
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text('News Feed')
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle),
                        title: Text(userState.firstname)
                    ),
                  ]
              );
            }
          );
        }
    );
  }
}
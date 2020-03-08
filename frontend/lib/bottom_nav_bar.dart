import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:outlook/states/user_state.dart';
import 'package:outlook/states/page_state.dart';

/// Handles the bottom navigation bar present across most pages.
/// Contains Discover, News Feed, and Profile tabs.
class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key key}): super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: UserState.getListenable(),
        builder: (context, userBox, child) {
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
                        title: Text(UserState.getFirstName())
                    ),
                  ]
              );
            }
          );
        }
    );
  }
}
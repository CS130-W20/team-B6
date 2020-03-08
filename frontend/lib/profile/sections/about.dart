import 'package:flutter/material.dart';
import 'package:outlook/states/user_state.dart';

/// Displays whatever description the user has set on their profile. Calls UserState.
class AboutSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: UserState.getListenable(),
        builder: (context, userBox, child) {
          UserState userState = UserState.getState();
          return Container(
             child: Padding(
                 padding: EdgeInsets.all(20),
                 child: Text(userState.description, style: TextStyle(fontSize: 16))
             )
          );
        }
    );
  }
}
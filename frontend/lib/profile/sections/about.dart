import 'package:flutter/material.dart';
import 'package:outlook/states/user_state.dart';

/// Displays whatever description the user has set on their profile. Calls UserState.
class AboutSection extends StatelessWidget {
  AboutSection({Key key, this.userData}): super(key: key);

  final userData;

  Widget buildChild(String description) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(description, style: TextStyle(fontSize: 16))
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    print(userData);
    if (userData['id'] == UserState.getId()) {
      return ValueListenableBuilder(
          valueListenable: UserState.getListenable(),
          builder: (context, userBox, child) {
            UserState userState = UserState.getState();
            return buildChild(userState.description);
          }
      );
    } else {
      return buildChild(userData['description']);
    }
  }
}
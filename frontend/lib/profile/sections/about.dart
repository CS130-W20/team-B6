import 'package:flutter/material.dart';
import 'package:outlook/user_state.dart';
import 'package:provider/provider.dart';

class AboutSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, userState, child) {
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
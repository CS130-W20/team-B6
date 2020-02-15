import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  AboutSection({Key key, this.description}): super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(description, style: TextStyle(fontSize: 16))
      )
    );
  }
}
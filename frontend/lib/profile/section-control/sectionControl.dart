import 'package:flutter/material.dart';
import 'package:flutter_app/profile/section-control/sectionControlNav.dart';

class SectionControl extends StatefulWidget {
  SectionControl({Key key}): super(key: key);

  _SectionControlState createState() => _SectionControlState();
}

class _SectionControlState extends State<SectionControl> {

  String currentSection = "Activity";

  void _changeSection(section) {
    setState(() {
      currentSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionControlNav(changeSection: this._changeSection),
        Text(currentSection)
      ],
    );
  }
}
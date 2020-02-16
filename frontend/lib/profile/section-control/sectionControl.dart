import 'package:flutter/material.dart';
import 'package:outlook/profile/sections/activity.dart';
import 'package:outlook/profile/sections/following.dart';
import 'package:outlook/profile/section-control/sectionControlNav.dart';
import 'package:outlook/profile/sections/about.dart';

PageController _controller = PageController(initialPage: 0);

class SectionControl extends StatefulWidget {
  SectionControl({Key key}): super(key: key);

  _SectionControlState createState() => _SectionControlState();
}

class _SectionControlState extends State<SectionControl> {

  int currentPage = 0;

  void _changeSection(int page) {
    setState(() {
      currentPage = page;
    });
    _controller.animateToPage(page, duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
    _controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    Widget section;
    switch (currentPage) {
      case 0:
        section = ActivitySection();
        break;
      case 1:
        section = FollowingSection();
        break;
      case 2:
        section = AboutSection(description: 'hello this is my description and it spans multiple rows just trying it out right now');
        break;
      default:
        section = Text('No information available.');
    }

    return Column(
      children: <Widget>[
        SectionControlNav(changeSection: _changeSection, currentPage: currentPage),
        Flexible(
            child: PageView(
              children: <Widget>[
                ActivitySection(),
                FollowingSection(),
                AboutSection(description: 'hello this is my description and it spans multiple rows just trying it out right now')
              ],
              onPageChanged: _changeSection,
              controller: _controller,
            )
        )

      ]
    );
  }
}
import 'package:flutter/material.dart';
import 'package:outlook/profile/sections/activity.dart';
import 'package:outlook/profile/sections/following.dart';
import 'package:outlook/profile/section-control/section_control_nav.dart';
import 'package:outlook/profile/sections/about.dart';

PageController _controller = PageController(initialPage: 0);

/// The root for the more specific contents of the profile page.
/// Controls whether the user's Activity, Following, or About section is displayed.
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
    _controller.animateToPage(page, duration: Duration(seconds: 1), curve: Curves.easeInOut);
    _controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionControlNav(changeSection: _changeSection, currentPage: currentPage),
        Flexible(
            child: PageView(
              children: <Widget>[
                ActivitySection(),
                FollowingSection(),
                AboutSection()
              ],
              onPageChanged: _changeSection,
              controller: _controller,
            )
        )

      ]
    );
  }
}
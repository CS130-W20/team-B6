import 'package:flutter/material.dart';
import 'package:outlook/profile/sections/activity.dart';
import 'package:outlook/profile/sections/following.dart';
import 'package:outlook/profile/section-control/section_control_nav.dart';
import 'package:outlook/profile/sections/about.dart';

/// The root for the more specific contents of the profile page.
/// Controls whether the user's Activity, Following, or About section is displayed.
class SectionControl extends StatefulWidget {
  SectionControl({Key key, this.userData}): super(key: key);

  final userData;

  _SectionControlState createState() => _SectionControlState();
}

class _SectionControlState extends State<SectionControl> {

  int currentPage = 0;
  PageController _controller = PageController(initialPage: 0);

  void _changeSection(int page) {
    setState(() {
      currentPage = page;
    });
    _controller.animateToPage(page, duration: Duration(seconds: 1), curve: Curves.easeInOut);
    _controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    print('section control ' + widget.userData['id'].toString());
    return Column(
      children: <Widget>[
        SectionControlNav(changeSection: _changeSection, currentPage: currentPage),
        Flexible(
            child: PageView(
              children: <Widget>[
                ActivitySection(userData: widget.userData),
                FollowingSection(userData: widget.userData),
                AboutSection(userData: widget.userData)
              ],
              onPageChanged: _changeSection,
              controller: _controller,
            )
        )

      ]
    );
  }
}
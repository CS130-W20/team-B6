import 'package:flutter/material.dart';

class SectionControlNav extends StatelessWidget {
  SectionControlNav({Key key, this.changeSection, this.currentPage}): super(key: key);

  final Function changeSection;
  int currentPage;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        SectionControlButton(
            changeSection: this.changeSection,
            name: "Activity",
            currentPage: currentPage,
            pageIndex: 0
        ),
        SectionControlButton(changeSection: this.changeSection,
            name: "Following",
            currentPage: currentPage,
            pageIndex: 1,
        ),
        SectionControlButton(changeSection: this.changeSection,
            name: "About",
            currentPage: currentPage,
            pageIndex: 2
        )
      ],
    );
  }
}

class SectionControlButton extends StatelessWidget {
  SectionControlButton({
    Key key,
    this.changeSection,
    this.name,
    this.currentPage,
    this.pageIndex
  }): super(key: key);

  final Function changeSection;
  final String name;
  int currentPage;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          changeSection(pageIndex);
        },
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                border: Border(
                  left: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1),
                  bottom: BorderSide(color: Color.fromRGBO(92, 179, 250, currentPage == pageIndex ? 0.5 : 0), width: 3)
                )
            ),
            child: Center(
                child: Text(name, style: TextStyle(fontSize: 15))
            )
        )
    );
  }
}
import 'package:flutter/material.dart';

class SectionControlNav extends StatelessWidget {
  SectionControlNav({Key key, this.changeSection}): super(key: key);

  final Function changeSection;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        SectionControlButton(changeSection: this.changeSection, name: "Activity"),
        SectionControlButton(changeSection: this.changeSection, name: "Following"),
        SectionControlButton(changeSection: this.changeSection, name: "About")
      ],
    );
  }
}

class SectionControlButton extends StatelessWidget {
  SectionControlButton({Key key, this.changeSection, this.name}): super(key: key);

  final Function changeSection;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          changeSection(name);
        },
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 50,
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                border: Border(
                  left: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1),
                )
            ),
            child: Center(
                child: Text(name, style: TextStyle(fontSize: 16))
            )
        )
    );
  }
}
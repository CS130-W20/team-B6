import 'package:flutter/material.dart';

class PageResources {
  PageResources({this.name, this.widget, this.actions});

  String name;
  Widget widget;
  List<Widget> actions = [];
}
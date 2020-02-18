import 'package:flutter/cupertino.dart';

class PageState extends ChangeNotifier {

  int currentIndex = 1;

  void changePage(int page) {
    currentIndex = page;
    notifyListeners();
  }
}
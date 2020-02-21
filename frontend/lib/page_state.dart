import 'package:flutter/cupertino.dart';

/// Used by the bottom nav bar to change between Discover, Activity, and Profile pages.
/// Other components use this state to determine whether they should render.
class PageState extends ChangeNotifier {

  int currentIndex = 1;

  void changePage(int page) {
    currentIndex = page;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:outlook/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:outlook/user_state.dart';
import 'package:outlook/bottom_nav_bar.dart';
import 'package:outlook/page_state.dart';
import 'package:outlook/page_resources.dart';
import 'story_main.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserState()),
      ChangeNotifierProvider(create: (context) => PageState())
    ],
    child: MyApp()
  )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Martel'
      ),
      home: MainLayout(),
    );
  }
}



class MainLayout extends StatelessWidget {

  PageResources createPageResources(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        return PageResources(
          name: 'Discover', 
          widget: Text('Discover')
          );
      case 1:
        return PageResources(
          name: 'Outlook', 
          widget: Text('Home'),
          actions: getNewsStory(context)
          );
      case 2:
        return PageResources(
            name: 'Your Profile',
            widget: ProfilePage(),
            actions: getProfileActions(context)
        );
    }
    return PageResources(name: '', widget: Container());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageState>(
      builder: (context, pageState, child) {
        PageResources pageResources = createPageResources(context, pageState.currentIndex);
        return Scaffold(
            appBar: AppBar(
                title: Text(pageResources.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    )
                ),
                iconTheme: IconThemeData(
                  color: Colors.black
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                actions: pageResources.actions
            ),
            body: pageResources.widget,
            bottomNavigationBar: BottomNavBar()
        );
      }
    );
  }
}

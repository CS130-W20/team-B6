import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outlook/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:outlook/user_state.dart';
import 'package:outlook/bottom_nav_bar.dart';
import 'package:outlook/page_state.dart';
import 'package:outlook/page_resources.dart';
import 'story_main.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Outlook());

/// The root of the entire app. Encompasses the loading screen logic, initialization logic,
/// and determines when it is appropriate to render the core of the app.
class Outlook extends StatefulWidget {

  _OutlookState createState() => _OutlookState();
}

class _OutlookState extends State<Outlook> with SingleTickerProviderStateMixin {

  bool loaded = false;
  UserState userState;

  @override
  void initState() {
    super.initState();
//    fetchUser();
  }

  /// Calls the backend for user specific user data like name, email, etc.
  /// and passes into the global UserState for the entire application to use.
  void fetchUser() async {
    final userDataResponse = await http.get('BACKEND API URL HERE');
    if (userDataResponse.statusCode == 200) {
       setState(() {
         userState = UserState.fromJson(jsonDecode(userDataResponse.body)[0]);
         loaded = true;
       });
    } else {
      userState = null;
    }
  }
  
  Widget wrapMaterialApp(Widget widget) {
    return MaterialApp(
      title: 'Outlook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Martel'
      ),
      home: widget
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = wrapMaterialApp(
        Scaffold(
            body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Outlook', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    )
                  ],
                )
            )
        )
    );

    if (true) {
      widget = MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserState(
              firstname: 'Clayton',
              lastname: 'Chu',
              username: 'claytonc',
              description: 'This is a cool description',
              email: 'clayton@example.com'
            )),
            ChangeNotifierProvider(create: (context) => PageState())
          ],
          child: wrapMaterialApp(MainLayout())
      );
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 750),
      child: widget
    );
  }
}


/// Contains the main part of the app, including discover, news feed, and profile page tabs.
/// This appears after the user has properly logged in and initialization data like user data has been retrieved.
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

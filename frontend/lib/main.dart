import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outlook/login/signup.dart';
import 'package:outlook/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:outlook/states/user_state.dart';
import 'package:outlook/bottom_nav_bar.dart';
import 'package:outlook/states/page_state.dart';
import 'package:outlook/page_resources.dart';
import 'story_main.dart';
import 'discover_main.dart';
import 'package:outlook/temp-stories.dart';
import 'package:outlook/managers/api_manager.dart';
import 'package:outlook/managers/firebase_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:outlook/states/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDirectory = await path_provider.getApplicationDocumentsDirectory();
  List<int> key = [];
  for (var i = 0; i < 32; i++) {
    key.add(i);
  }
  await Hive.initFlutter(appDocDirectory.path);

  await Hive.openBox(AuthState.AUTH_BOX);
  await Hive.openBox(UserState.USER_BOX, encryptionCipher: HiveAesCipher(key));
  // UNCOMMENT THIS OUT RESET STORAGE DATA
//  await Hive.box(AuthState.AUTH_BOX).clear();
//  await Hive.box(UserState.USER_BOX).clear();

  runApp(Outlook());
}

/// The root of the entire app. Encompasses the loading screen logic, initialization logic,
/// and determines when it is appropriate to render the core of the app.
class Outlook extends StatefulWidget {
  _OutlookState createState() => _OutlookState();
}

class _OutlookState extends State<Outlook> with SingleTickerProviderStateMixin {

  bool userDataLoaded = false;
  bool userDataLoading = true;

  @override
  void initState() {
    super.initState();
    initFirebase();
    fetchUser();
  }

  getUserData() async {
    final userDataResponse = await ApiManager.getUserData(UserState.getId());
    if (userDataResponse.statusCode == 200) {
      print(jsonDecode(userDataResponse.body));
      UserState.fromJson(jsonDecode(userDataResponse.body));
      setState(() {
        userDataLoading = false;
        userDataLoaded = true;
      });
    } else {
      setState(() {
        userDataLoading = false;
        userDataLoaded = false;
      });
    }
  }

  /// Calls the backend for user specific user data like name, email, etc.
  /// and passes into the global UserState for the entire application to use.
  void fetchUser() async {
    print('authtoken ' + AuthState.getToken());
    if (AuthState.getToken() == '') {
      print('attempting to log in');
      final loginResponse = await ApiManager.login(UserState.getUserName(), AuthState.getPassword());
      print(loginResponse.statusCode);
      if (loginResponse.statusCode == 200) {
        var loginData = jsonDecode(loginResponse.body);
        AuthState.setToken(loginData['token']);
        UserState.setId(loginData['id']);
        print('attempting to get user data');
        await getUserData();
      } else {
        print('b');
        setState(() {
          userDataLoading = false;
          userDataLoaded = false;
        });
      }
    } else {
      print('c');
      if (UserState.getFirstName().length == 0
          || UserState.getLastName().length == 0
          || UserState.getUserName().length == 0
        ) {
        await getUserData();
      } else {
        print('d');
        setState(() {
          userDataLoading = false;
          userDataLoaded = true;
        });
      }
    }
  }

  void initFirebase() async {
    await FirebaseManager.initStorage();
  }

  Widget wrapMaterialApp(Widget widget) {
    return MaterialApp(
      title: 'Outlook',
      debugShowCheckedModeBanner: false,
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

    if (!userDataLoading && userDataLoaded) {
      print('.');
      widget = MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => PageState())
          ],
          child: wrapMaterialApp(MainLayout())
      );
    } else if (!userDataLoading && !userDataLoaded) {
      // widget = wrapMaterialApp(SignUpPage());
      widget = MultiProvider(
          providers: [
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

  String datapass = 'asddd';

  PageResources createPageResources(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        return PageResources(
          name: 'Discover', 
          widget: DiscoverPage()
          );
      case 1:
        return PageResources(
          name: 'Outlook', 
          widget: AppHome(),
          actions: getNewsStory(context,datapass)
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

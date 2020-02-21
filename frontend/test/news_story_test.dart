// import 'package:flutter/material.dart';mport 'package:flutter_app/story_main.dart';
import 'dart:js';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outlook/news_story.dart';
import 'package:test/test.dart' as testtemp;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();


  testtemp.test ('Swipe Left to open the browser', () {

    var result = BrowserSwipeValidator.validate('www.google.com');
    print('Testing now...');
    result.then((val) {
      print(val);
      print('Future returned in test.');
      expect(val, 'url launched');
    });

    // expect(result, Future.value('Could not launch url'));
    // expect(result, 'Could not launch url');
  });



  testtemp.test ('Swipe to go back to home page', () {
    BuildContext context;
    var result = HomePageValidator.validate(context);
    print('Testing now...');
    expect(result, 'going back to home page');
    

    // expect(result, Future.value('Could not launch url'));
    // expect(result, 'Could not launch url');
  });



}




// Swiping left to open the browser 
// Swiping up or down to go back to the home page 
// Tapping on the right side of the screen to go to the next story (Edge case - Last story)
// Tapping on the left side of the screen to go the previous story (Edge case - First story)


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outlook/feed-stories.dart';
import 'package:outlook/main.dart';

void main() {
  testWidgets('News Feed Tester Start...', (WidgetTester tester) async {
    // Start building the app
    await tester.pumpWidget(Outlook());
    expect(find.text('Outlook'), findsOneWidget);
    // Verify the presence of FeedStories widget in the feed
    expect(find.byWidget(FeedStories()), findsOneWidget);
    //Verfiy the presence of the following icon, which is present in the newsfeed
    expect(find.byIcon(Icons.announcement), findsNothing);
    //Verfiy the presence of the following icon, which is present in the newsfeed
    expect(find.byIcon(Icons.arrow_upward), findsNothing);
  });
}

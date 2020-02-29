// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:outlook/main.dart';

void main() {
  testWidgets('Splash screen appears first', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Outlook());

    // Verify that content appears ("Outlook" appears almost everywhere)
    expect(find.text('Outlook'), findsOneWidget);
    // Verify that the bottom nav bar is not displaying, meaning MainLayout() is not rendered.
    expect(find.text('Discover'), findsNothing);
    // Verify that news feed, which has this icon, is not rendered
    expect(find.byIcon(Icons.calendar_today), findsNothing);
    // Verify that profile page, which has this icon, is not rendered
    expect(find.byIcon(Icons.mode_edit), findsNothing);
  });
}

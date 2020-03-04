import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outlook/comments/comment.dart';

void main() {
  final pic = AssetImage('assets/defaultprofilepic.jpg');
  var comment = Comment('claim', 'argument', pic, 'name');
  testWidgets('comment widget has commenter name, claim, and argument', (WidgetTester tester) async {
    await tester.pumpWidget(comment.getWidget());

    final claimFinder = find.text('claim');
    final argumentFinder = find.text('argument');
    final nameFinder = find.text("name");

    expect(claimFinder, findsOneWidget);
    expect(argumentFinder, findsOneWidget);
    expect(nameFinder, findsOneWidget);
  });

  testWidgets('comment preview has commenter name and claim', (WidgetTester tester) async {
    await tester.pumpWidget(comment.getPreview());

    final claimFinder = find.text('claim');
    final argumentFinder = find.text('argument');
    final nameFinder = find.text("name");

    expect(claimFinder, findsOneWidget);
    expect(argumentFinder, findsNothing);
    expect(nameFinder, findsOneWidget);
  });
}

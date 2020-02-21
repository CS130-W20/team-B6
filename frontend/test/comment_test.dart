import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outlook/comment.dart';

void main() {
  testWidgets('comment has commenter name, claim, and argument', (WidgetTester tester) async {
    final pic = AssetImage('assets/defaultprofilepic.jpg');
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child:
            Comment(
        'claim',
        'argument',
        pic,
        "name"))));
    final claimFinder = find.text('claim');
    final argumentFinder = find.text('argument');
    final nameFinder = find.text("name");
    expect(claimFinder, findsOneWidget);
    expect(argumentFinder, findsOneWidget);
    expect(nameFinder, findsOneWidget);
  });

  testWidgets('comment preview has commenter name and claim', (WidgetTester tester) async {
    final pic = AssetImage('assets/defaultprofilepic.jpg');
    final comment = Comment(
        'claim',
        'argument',
        pic,
        "name");
    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        return MaterialApp(home: Material(child: comment.commentPreview(context)));
      },
    ));
    final claimFinder = find.text('claim');
    final argumentFinder = find.text('argument');
    final nameFinder = find.text("name");
    expect(claimFinder, findsOneWidget);
    expect(argumentFinder, findsNothing);
    expect(nameFinder, findsOneWidget);
  });
}

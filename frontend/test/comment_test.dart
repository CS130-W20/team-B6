import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outlook/comments/comment.dart';

void main() {
  final pic = AssetImage('assets/defaultprofilepic.jpg');
  var comment = Comment('claim', 'argument', pic, 'name');
  testWidgets('comment widget has commenter name, claim, and argument', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child:comment.getWidget())));

    final claimFinder = find.text('claim');
    final argumentFinder = find.text('argument');
    final nameFinder = find.text("name");

    expect(claimFinder, findsOneWidget);
    expect(argumentFinder, findsOneWidget);
    expect(nameFinder, findsOneWidget);
  });

  testWidgets('comment preview has commenter name and claim', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child:comment.getPreview())));

    final claimFinder = find.text('claim');
    final argumentFinder = find.text('argument');
    final nameFinder = find.text("name");

    expect(claimFinder, findsOneWidget);
    expect(argumentFinder, findsNothing);
    expect(nameFinder, findsOneWidget);
  });

  testWidgets('comment preview is stored as a singleton', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child:comment.getPreview())));
    final previewFinder = find.byWidget(comment.getPreview());
    expect(previewFinder, findsOneWidget);
    //tester.press(find.byWidget(comment.getPreview()));
  });

  testWidgets('tapping comment preview leads to comment page', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child:comment.getPreview())));

    final pageFinder = find.byWidget(comment.getPage());
    expect(pageFinder, findsNothing);

    await tester.tap(find.byWidget(comment.getPreview()));
    await tester.pumpAndSettle();
    
    expect(pageFinder, findsOneWidget);
  });
}

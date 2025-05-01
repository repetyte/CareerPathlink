import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Job Posting Screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Job Postings'), findsOneWidget);
  });
}

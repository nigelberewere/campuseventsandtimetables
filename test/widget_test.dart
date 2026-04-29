import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campuseventsandtimetables/main.dart';

void main() {
  testWidgets('starts on landing page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Campus Events &\nTimetables'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('valid sign in opens the home page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Student email'),
      'student@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Campus Events & Timetables'), findsOneWidget);
    expect(find.text('Featured Events'), findsOneWidget);
  });
}

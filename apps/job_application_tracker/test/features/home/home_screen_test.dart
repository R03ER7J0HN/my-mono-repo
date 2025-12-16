import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_application_tracker/features/home/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders correctly with mock data',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Let the cubit load the data and the UI rebuild
    await tester.pumpAndSettle();

    // Verify that the welcome text is present.
    expect(find.text('Welcome Back!'), findsOneWidget);

    // Verify the interview card is present.
    expect(find.text('Upcoming Interview Today!'), findsOneWidget);
    expect(find.text('Tech Innovations Inc.'), findsOneWidget);

    // Verify the stats card is present.
    expect(find.text('Progress Overview'), findsOneWidget);
    expect(find.text('25%'), findsOneWidget);

    // Verify the metric cards are present.
    expect(find.text('Total Applications'), findsOneWidget);
    expect(find.text('60'), findsOneWidget);
    expect(find.text('Offers Received'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });
}

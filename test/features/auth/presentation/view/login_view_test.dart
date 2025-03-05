import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/features/auth/presentation/view/login_view.dart';

void main() {
  testWidgets("Widget Test 1 Login screen should have title", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginView(),
    ));

    // Verify if the title "Welcome To Jagga Bazar" is present
    expect(find.text("Welcome To Jagga Bazar"), findsOneWidget);
  });

  testWidgets("Widget Test 2 Enter username & password and tap login", (tester) async {
  await tester.pumpWidget(const MaterialApp(
    home: LoginView(),
  ));

  await tester.pumpAndSettle();

  // Enter username & password
  await tester.enterText(find.byType(TextFormField).at(0), 'testUser');
  await tester.enterText(find.byType(TextFormField).at(1), 'password123');

  // Tap Login button
  await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
  await tester.pumpAndSettle();

  // No direct result expectation (since login depends on BLoC), just checking interactions
});

testWidgets("Widget Test 3 Show validation error if fields are empty", (tester) async {
  await tester.pumpWidget(const MaterialApp(
    home: LoginView(),
  ));

  await tester.pumpAndSettle();

  // Tap Login button without entering any input
  await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
  await tester.pumpAndSettle();

  // Expect validation messages
  expect(find.text("Please enter your username"), findsOneWidget);
  expect(find.text("Please enter your password"), findsOneWidget);
});







}

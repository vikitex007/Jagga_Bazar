import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/features/auth/presentation/view/register_view.dart';

void main() {

  /// 1️⃣ Test - Check if all form fields are visible
  testWidgets("Widget test 4 Register screen should show all input fields", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RegisterView(),
    ));

    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget); // The button
  });

  /// 2️⃣ Test - Show validation error if fields are empty and register button is clicked
  testWidgets("Widget Test 5 Show validation error when trying to register with empty fields", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RegisterView(),
    ));

    // Tap Register button directly
    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pumpAndSettle();

    // Check for validation messages
    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Please enter your Location'), findsOneWidget);
    expect(find.text('Please enter your username'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  /// 3️⃣ Test - Fill form and check no errors (basic happy path test)
  testWidgets("Widget Test 6 Fill all fields correctly and press register", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RegisterView(),
    ));

    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe'); // Full Name
    await tester.enterText(find.byType(TextFormField).at(1), '9800000000'); // Phone
    await tester.enterText(find.byType(TextFormField).at(2), 'Kathmandu'); // Location
    await tester.enterText(find.byType(TextFormField).at(3), 'john123'); // Username
    await tester.enterText(find.byType(TextFormField).at(4), 'password123'); // Password

    await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
    await tester.pumpAndSettle();

    // This test does not check any final result - assumes bloc interaction happens.
    // You can optionally add mock bloc verification if needed.
  });
}

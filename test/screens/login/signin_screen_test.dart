import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:Sashimi/Screens/Login/signin_screen.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late SignInScreen signInScreen;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    signInScreen = const SignInScreen();
  });

  testWidgets('Sign in with valid credentials', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: signInScreen));

    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final signInButton = find.byKey(const Key('sign_in_button'));

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.tap(signInButton);
    await tester.pump();

    verify(mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password',
    )).called(1);
    // Add assertions for the expected behavior after successful sign-in
  });

  testWidgets('Sign in with invalid credentials', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: signInScreen));

    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final signInButton = find.byKey(const Key('sign_in_button'));

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'wrong_password');
    await tester.tap(signInButton);
    await tester.pump();

    // Add assertions for the expected behavior after failed sign-in
  });

  // Add more test cases to cover other scenarios
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blood_link/main.dart'; // Import your main app
import 'package:blood_link/login.dart'; // Import your splash screen and login screen

void main() {
  testWidgets('Splash screen shows and navigates to LoginScreen', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    // The MyApp widget starts with SplashScreen as its home.
    await tester.pumpWidget(const MyApp());

    // Verify that the SplashScreen is displayed.
    // We can look for the "BloodLink" text or the heart icon.
    expect(find.text('BloodLink'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Wait for the splash screen's timer to complete.
    // The SplashScreen has a 3-second timer, so we pump for more than that.
    await tester.pumpAndSettle(
      const Duration(seconds: 4),
    ); // Wait for 4 seconds to ensure navigation

    // After the timer, the app should navigate to the LoginScreen.
    // Verify that elements from the LoginScreen are now present.
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Log in'), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);

    // Optionally, you can interact with the LoginScreen elements here.
    // For example, tapping the "Sign up" text.
    await tester.tap(find.text('Sign up'));
    await tester.pump(); // Rebuild the widget after the tap

    // You could add expectations here if tapping 'Sign up' leads to a new screen
    // or changes the UI in a testable way.
  });
}

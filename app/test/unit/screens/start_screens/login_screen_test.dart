import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itflowapp/screens/start_screens/login_screen.dart';
import 'package:itflowapp/widgets/forms/login_form.dart';

void main() {
  testWidgets('LoginScreen should render properly',
      (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Check that the app bar has the correct title.
    expect(find.text('ItFlow'), findsOneWidget);

    // Check that the login form is displayed.
    expect(find.byType(LoginForm), findsOneWidget);

    // Check that the text widgets have the correct font sizes.
    final niceToSeeYouAgain =
        tester.widget<Text>(find.text('Nice to see you again!'));
    expect(niceToSeeYouAgain.style?.fontSize, equals(45.0));

    final letsGetYouSignedIn =
        tester.widget<Text>(find.text("Let's get you signed in!"));
    expect(letsGetYouSignedIn.style?.fontSize, equals(40.0));
  });
}

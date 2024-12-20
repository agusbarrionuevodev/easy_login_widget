import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generic_login/generic_login.dart';

void main() {
  testWidgets('CustomLogin widget renders correctly',
      (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: CustomLogin(
          formKey: formKey,
          userNameController: userNameController,
          passwordController: passwordController,
          onPressed: () {},
          buttonWidgetFirstOrLast: true,
        ),
      ),
    ));

    expect(find.text('Sign In'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
  testWidgets('Button press triggers validation', (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    bool buttonPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: CustomLogin(
          formKey: formKey,
          userNameController: userNameController,
          passwordController: passwordController,
          onPressed: () {
            buttonPressed = true;
          },
          buttonWidgetFirstOrLast: true,
          userNameValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
          passwordValidator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
        ),
      ),
    ));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(formKey.currentState?.validate(), isFalse);
    expect(buttonPressed, isTrue);
  });
  testWidgets('Password visibility toggles on icon press',
      (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: CustomLogin(
          formKey: formKey,
          userNameController: userNameController,
          passwordController: passwordController,
          onPressed: () {},
          buttonWidgetFirstOrLast: true,
        ),
      ),
    ));

    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });
  testWidgets('Optional widgets visibility based on parameters',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: CustomLogin(
          formKey: GlobalKey<FormState>(),
          userNameController: TextEditingController(),
          passwordController: TextEditingController(),
          onPressed: () {},
          buttonWidgetFirstOrLast: true,
          forgotPasswordWidgetVisibility: true,
          rememberMeWidgetVisibility: true,
          rememberMeText: 'Remember Me',
          forgotPasswordText: 'Forgot Password?',
        ),
      ),
    ));

    expect(find.text('Remember Me'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
  });
  testWidgets('onChangedUsername and onChangedPassword are called',
      (WidgetTester tester) async {
    String? username;
    String? password;

    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: CustomLogin(
          formKey: GlobalKey<FormState>(),
          userNameController: TextEditingController(),
          passwordController: TextEditingController(),
          onPressed: () {},
          buttonWidgetFirstOrLast: true,
          onChangedUsername: (value) => username = value,
          onChangedPassword: (value) => password = value,
        ),
      ),
    ));

    await tester.enterText(find.byType(TextFormField).first, 'test_user');
    await tester.enterText(find.byType(TextFormField).last, 'test_pass');

    expect(username, 'test_user');
    expect(password, 'test_pass');
  });
}

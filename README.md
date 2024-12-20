<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

This is a flutter package that provides a simple way to create a easy login for your flutter project.

## Features

With this package you will be able to add a login screen to your project with a few lines of code.

## Getting started

To use this package you will have to install it and import it in your project. After taking that step, you will be able to call the EasyLoginWidget within te package and customize it according to your needs.

```yaml 
dependencies:
  easy_login_widget: ^1.0.0
```

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Easy Login Widget',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EasyLoginWidget(
          formKey: formKey,
          userNameController: userNameController,
          passwordController: passwordController,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              print('Username: ${userNameController.text}');
            }
          },
          buttonWidgetFirstOrLast: true,
          userNameValidator: (value) =>
          value == null || value.isEmpty ? 'Required' : null,
          passwordValidator: (value) =>
          value == null || value.isEmpty ? 'Required' : null,
          rememberMeText: 'Remember me',
          rememberMeWidgetVisibility: true,
          forgotPasswordWidgetVisibility: true,
          forgotPasswordText: 'Forgot password',
          inputSpacing: 10,
        ),
      ),
    );
  }
}
```

## Additional information

If you want to know more about the package or contribute to it, please visit the [GitHub repository](https://github.com/agusbarrionuevodev/easy_login_widget.git). Or email me at agusbarrionuevodev@gmail.com
Thank you!
import 'package:flutter/material.dart';
import 'package:easy_login_widget/easy_login_widget.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EasyLoginWidget(
          formKey: GlobalKey<FormState>(),
          buttonWidgetFirstOrLast: true,
          onPressedForgotPassword: () {},
          forgotPasswordStyle: const TextStyle(color: Colors.blue),
          forgotPasswordWidgetVisibility: true,
          rememberMeWidgetVisibility: true,
          userNameInputLabel: 'Username',
          passwordInputLabel: 'Password',
          buttonTextStyle: const TextStyle(color: Colors.white),
          rememberMeText: 'Remember me',
          inputSpacing: 10,
          checkBoxActiveColor: Colors.blue,
          checkBoxCheckColor: Colors.white,
        ),
      ),
    );
  }
}

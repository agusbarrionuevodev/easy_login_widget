import 'package:flutter/material.dart';

class EasyLoginWidget extends StatefulWidget {
  final InputDecoration? userNameInputDecoration;
  final InputDecoration? passwordInputDecoration;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final Function() onPressed;
  final Function()? onPressedForgotPassword;
  final Function(String)? onChangedUsername;
  final Function(String)? onChangedPassword;
  final Function(String?)? passwordValidator;
  final Function(String?)? userNameValidator;
  final GlobalKey<FormState> formKey;
  final String buttonText;
  final ButtonStyle? buttonStyle;
  final double? buttonWidth;
  final double? buttonHeigth;
  final AutovalidateMode? autoValidateMode;
  final bool forgotPasswordWidgetVisibility;
  final bool rememberMeWidgetVisibility;
  final String? forgotPasswordText;
  final TextStyle? forgotPasswordStyle;
  final TextStyle? buttonTextStyle;
  final String? userNameInputLabel;
  final String? passwordInputLabel;
  final bool buttonWidgetFirstOrLast;
  final String? rememberMeText;
  final double? inputSpacing;
  final Color? checkBoxActiveColor;
  final Color? checkBoxCheckColor;

  const EasyLoginWidget({
    super.key,
    required this.formKey,
    required this.userNameController,
    required this.passwordController,
    required this.onPressed,
    required this.buttonWidgetFirstOrLast,
    this.userNameInputDecoration,
    this.passwordInputDecoration,
    this.passwordValidator,
    this.userNameValidator,
    this.onChangedUsername,
    this.onChangedPassword,
    this.buttonText = 'Sign In',
    this.buttonStyle,
    this.buttonWidth,
    this.buttonHeigth,
    this.autoValidateMode,
    this.forgotPasswordText,
    this.onPressedForgotPassword,
    this.forgotPasswordStyle,
    this.forgotPasswordWidgetVisibility = false,
    this.rememberMeWidgetVisibility = false,
    this.userNameInputLabel,
    this.passwordInputLabel,
    this.buttonTextStyle,
    this.rememberMeText,
    this.inputSpacing = 0,
    this.checkBoxActiveColor,
    this.checkBoxCheckColor,
  });

  @override
  State<EasyLoginWidget> createState() => _EasyLoginWidgetState();
}

class _EasyLoginWidgetState extends State<EasyLoginWidget> {
  bool visible = true;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildUserNameInput(),
            SizedBox(height: widget.inputSpacing),
            buildPasswordInput(),
            SizedBox(height: widget.inputSpacing),
            widget.buttonWidgetFirstOrLast
                ? Column(
                    children: [
                      buildButton(),
                      optionalWidgets(),
                    ],
                  )
                : Column(
                    children: [
                      optionalWidgets(),
                      buildButton(),
                    ],
                  ),
            SizedBox(height: widget.inputSpacing),
            widget.forgotPasswordWidgetVisibility
                ? Align(
              alignment: Alignment.center,
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                onPressed: widget.onPressedForgotPassword,
                child: Text(
                  widget.forgotPasswordText!,
                  style: widget.forgotPasswordStyle ??
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            )
                : const SizedBox.shrink()
          ],
        ),
      );
  }

  Row optionalWidgets() {
    return widget.rememberMeWidgetVisibility
            ? Row(
                children: [
                  Checkbox(
                    activeColor: widget.checkBoxActiveColor ?? Colors.blue,
                    checkColor: widget.checkBoxCheckColor ?? Colors.white,
                    value: checkboxValue,
                    onChanged: (value) {
                      checkboxValue = value!;
                      setState(() {});
                    },
                  ),
                  Text(widget.rememberMeText ?? ' ',
                      style: widget.forgotPasswordStyle),
                ],
              )
            : const SizedBox.shrink();
  }

  Column buildUserNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.userNameInputLabel != null
            ? Text(widget.userNameInputLabel!)
            : const SizedBox.shrink(),
        Container(
          margin: const EdgeInsets.only(top: 2),
          height: 80,
          child: TextFormField(
            autovalidateMode: widget.autoValidateMode,
            onChanged: (value) => widget.onChangedUsername?.call(value),
            validator: (value) => widget.userNameValidator?.call(value),
            controller: widget.userNameController,
            decoration: widget.userNameInputDecoration ??
                const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username...',
                ),
          ),
        ),
      ],
    );
  }

  SizedBox buildButton() {
    bool areValidationsEnabled =
        widget.passwordValidator != null && widget.userNameValidator != null;
    return SizedBox(
      width: widget.buttonWidth ?? double.infinity,
      height: widget.buttonHeigth ?? 40,
      child: ElevatedButton(
        style: widget.buttonStyle ??
            ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        onPressed: () {
          if (areValidationsEnabled) widget.formKey.currentState?.validate();
          widget.onPressed();
        },
        child: Text(widget.buttonText, style: widget.buttonTextStyle),
      ),
    );
  }

  Column buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.passwordInputLabel != null
            ? Text(widget.passwordInputLabel!)
            : const SizedBox.shrink(),
        Container(
          margin: const EdgeInsets.only(top: 2),
          height: 80,
          child: TextFormField(
            autovalidateMode: widget.autoValidateMode,
            validator: (value) => widget.passwordValidator?.call(value),
            onChanged: (value) => widget.onChangedPassword?.call(value),
            controller: widget.passwordController,
            obscureText: visible,
            decoration: widget.passwordInputDecoration?.copyWith(
                  suffixIcon: IconButton(
                      onPressed: () {
                        visible = !visible;
                        setState(() {});
                      },
                      icon: visible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                ) ??
                InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter your password...',
                  suffixIcon: IconButton(
                      onPressed: () {
                        visible = !visible;
                        setState(() {});
                      },
                      icon: visible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                ),
          ),
        ),
      ],
    );
  }
}

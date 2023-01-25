import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/extensions/extensions.dart';
import '../../../config/Themes/colors.dart';
import '../../../config/Themes/text_styles.dart';
import '../../../core/components/app_cupertino_button.dart';
import '../../../core/components/base_stateless_widget.dart';
import '../../../core/components/check_boc.dart';
import '../../../core/components/material_text_field.dart';

class LoginScreen extends BaseStatelessWidget {
  final Function onClickLogin;

  LoginScreen({required this.onClickLogin});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration(),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(child: buildLoginForm(context))),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [logoWidget(), welcomeText(), credentialForm()],
      ),
    );
  }

  Widget logoWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Align(
          alignment: AlignmentDirectional.centerStart, child: Container()),
    );
  }

  Widget welcomeText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        strings.welcome_text,
        style: welcomeTextStyle(),
      ),
    );
  }

  Widget credentialForm() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 16),
      decoration: boxShadow(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            loginLabel(),
            personalIdTextField(),
            passwordTextField(),
            rememberRow(),
            loginButton()
          ],
        ),
      ),
    );
  }

  BoxDecoration boxShadow() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: kBlueGrey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(2, 2), // c
        )
      ],
      borderRadius: BorderRadius.circular(23),
    );
  }

  loginLabel() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        strings.login_title,
        style: kTextRegular.copyWith(fontSize: 28, color: kFontBlue),
      ),
    );
  }

  TextStyle welcomeTextStyle() =>
      kTextLight.copyWith(fontSize: 25, color: kFontBlue);

  Widget personalIdTextField() {
    return MaterialTextField(
      margin: EdgeInsets.only(top: 16),
      validator: (value) {
        if (value.isNullOrEmpty()) {
          return strings.invalid_id;
        }
        return null;
      },
    );
  }

  passwordTextField() {
    return MaterialTextField(
      margin: EdgeInsets.only(top: 20),
      obscureText: true,
      validator: (value) {
        if (value.isNullOrEmpty()) {
          return strings.invalid_password;
        }
        return null;
      },
    );
  }

  InputDecoration fieldDecoration({required String iconSvgPath, String? hint}) {
    return kTextFieldDecoration.copyWith(
        prefixIcon: SvgPicture.asset(
          iconSvgPath,
          color: kBorderColor,
        ),
        hintText: hint,
        prefixIconConstraints: BoxConstraints(maxHeight: 24, minWidth: 45));
  }

  rememberRow() {
    return Row(
      children: [
        Expanded(
            child: MaterialCheckBox(
          label: strings.remember_me,
        )),
        forgetPasswordText()
      ],
    );
  }

  loginButton() {
    return AppCupertinoButton(
      child: buttonText(),
      margin: EdgeInsets.only(top: 25),
      onPressed: () {
        performLogin();
      },
    );
  }

  Decoration backgroundDecoration() {
    return BoxDecoration();
  }

  forgetPasswordText() {
    return Text(
      strings.forget_password,
      style: forgetPasswordTextStyle(),
    );
  }

  forgetPasswordTextStyle() => kTextLight.copyWith(
        fontSize: 16,
        color: kGrey_68,
        decoration: TextDecoration.underline,
      );

  buttonText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          strings.login_button,
          style: kButtonTextStyle,
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }

  void performLogin() {
    if (_formKey.currentState?.validate() == true) {
      onClickLogin();
    }
  }
}

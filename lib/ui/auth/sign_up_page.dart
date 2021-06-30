import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/size_config.dart';
import '../../services/auth_services.dart';
import '../../state/user_state.dart';
import '../../common/themes.dart';
import '../../services/info_services.dart';
import '../../widgets/reuse/reusable_button.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userC = Get.find<UserState>();
  bool obscureText = true;
  bool isLoading = false;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sign Up', style: authTitleStyle),
        Text('To Start HelloPetty!', style: authSubtitleStyle),
      ],
    );

    Widget inputUsername = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username', style: authLabelStyle),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 0.81).roundToDouble(),
        ),
        TextField(
          controller: username,
          style: standardStyle,
          textInputAction: TextInputAction.next,
          decoration: authFieldDecoration.copyWith(
            hintText: 'Enter your username',
            prefixIcon: authIcon(Icons.person),
          ),
        ),
      ],
    );

    Widget inputEmail = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: authLabelStyle),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 0.81).roundToDouble(),
        ),
        TextField(
          controller: email,
          style: standardStyle,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: authFieldDecoration.copyWith(
            hintText: 'Enter your email',
            prefixIcon: authIcon(Icons.mail),
          ),
        ),
      ],
    );

    Widget inputPassword = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: authLabelStyle),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 0.81).roundToDouble(),
        ),
        TextField(
          controller: password,
          style: standardStyle,
          obscureText: obscureText,
          decoration: authFieldDecoration.copyWith(
            hintText: 'Enter your password',
            prefixIcon: authIcon(Icons.lock),
            suffixIcon: IconButton(
              icon: authIcon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                obscureText = !obscureText;
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );

    Widget signUpButton = isLoading
        ? Center(child: CircularProgressIndicator())
        : ReusableButton(
            color: primaryColor,
            width: double.infinity,
            child: Text('Sign Up', style: authTextButtonStyle),
            height: (SizeConfig.safeBlockVertical * 8.1).roundToDouble(),
            onPressed: () async {
              if (username.text.isEmpty) {
                showErrorSnackbar(
                  message: 'Username cannot be empty.',
                );
              } else if (username.text.length < 4) {
                showErrorSnackbar(
                    message: 'Username must be at least 4 characters long.');
              } else {
                setState(() => isLoading = true);

                User createdUser = await AuthServices.signUp(
                  email: email.text,
                  password: password.text,
                );

                if (createdUser != null && !createdUser.emailVerified) {
                  await createdUser.sendEmailVerification();
                  await userC.setUser(createdUser, displayName: username.text);
                  showAlertDialog(
                    titleText: 'Verification',
                    contentText:
                        'Before you can get started, you need to verify your account email address.',
                    onPressed: () {
                      setState(() => isLoading = false);
                      Get.offNamed('/sign_in');
                    },
                  );
                } else {
                  setState(() => isLoading = false);
                }
              }
            },
          );

    Widget signInOption = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(
            color: grayColor,
            fontWeight: medium,
            fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
          ),
        ),
        TextButton(
          onPressed: () => isLoading ? null : Get.offNamed('/sign_in'),
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Color(0xff322F44),
              decoration: TextDecoration.underline,
              fontWeight: medium,
              fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 2.4).roundToDouble(),
                  ),
                  inputUsername,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                  ),
                  inputEmail,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                  ),
                  inputPassword,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 3.9).roundToDouble(),
                  ),
                  signUpButton,
                  signInOption,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

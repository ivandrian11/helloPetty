import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/size_config.dart';
import '../../services/auth_services.dart';
import '../../services/info_services.dart';
import '../../state/user_state.dart';
import '../../common/themes.dart';
import '../../widgets/once/horizontal_line_text.dart';
import '../../widgets/reuse/reusable_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final userC = Get.find<UserState>();
  bool isLoading = false;
  bool isLoadingGmail = false;
  bool obscureText = true;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome!', style: authTitleStyle),
        Text('Sign In to Continue', style: authSubtitleStyle),
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
                  obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                obscureText = !obscureText;
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );

    Widget passwordOption = Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap:
            isLoading || isLoadingGmail ? null : () => Get.toNamed('/forgot'),
        child: Text(
          'Forgot your password?',
          style: TextStyle(
            color: grayColor,
            decoration: TextDecoration.underline,
            fontWeight: medium,
            fontSize: (SizeConfig.safeBlockHorizontal * 3.3).roundToDouble(),
          ),
        ),
      ),
    );

    Widget signInButton = isLoading
        ? Center(child: CircularProgressIndicator())
        : ReusableButton(
            color: primaryColor,
            width: double.infinity,
            child: Text('Sign In', style: authTextButtonStyle),
            height: (SizeConfig.safeBlockVertical * 8.1).roundToDouble(),
            onPressed: isLoadingGmail
                ? null
                : () async {
                    setState(() => isLoading = true);
                    User loggedInUser = await AuthServices.signIn(
                      email: email.text,
                      password: password.text,
                    );

                    setState(() => isLoading = false);

                    if (loggedInUser != null) {
                      if (!loggedInUser.emailVerified) {
                        showErrorSnackbar(
                            message: 'You must verify your account first.');
                      } else {
                        Get.offNamed('/main');
                      }
                    }
                  },
          );

    Widget gmailButton = isLoadingGmail
        ? Center(child: CircularProgressIndicator())
        : ReusableButton(
            color: whiteColor,
            borderColor: primaryColor,
            width: double.infinity,
            height: (SizeConfig.safeBlockVertical * 8.1).roundToDouble(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connect with',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize:
                        (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  width: (SizeConfig.safeBlockHorizontal * 1.1).roundToDouble(),
                ),
                Image.asset(
                  'assets/icon/google.png',
                  width:
                      (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
                ),
              ],
            ),
            onPressed: isLoading
                ? null
                : () async {
                    setState(() => isLoadingGmail = true);
                    final gmailUser = await AuthServices.signInWithGoogle();
                    if (gmailUser != null) {
                      final isFirst = await getPref('isFirstGmailLogin');
                      print(isFirst);
                      if (isFirst) {
                        await savePref('isFirstGmailLogin');
                        await userC.setUser(gmailUser);
                      }
                      setState(() => isLoadingGmail = false);
                      Get.offNamed('/main');
                    } else {
                      setState(() => isLoadingGmail = false);
                    }
                  },
          );

    Widget signUpOption = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don’t have an account?',
          style: TextStyle(
            color: grayColor,
            fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
            fontWeight: medium,
          ),
        ),
        TextButton(
          onPressed: isLoading || isLoadingGmail
              ? null
              : () => Get.offNamed('/sign_up'),
          child: Text(
            'Sign Up',
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
                  inputEmail,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                  ),
                  inputPassword,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 0.81).roundToDouble(),
                  ),
                  passwordOption,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 2.6).roundToDouble(),
                  ),
                  signInButton,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 2.6).roundToDouble(),
                  ),
                  HorizontalLineText('or'),
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 2.6).roundToDouble(),
                  ),
                  gmailButton,
                  signUpOption,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

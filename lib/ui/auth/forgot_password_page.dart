import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../common/size_config.dart';
import '../../services/auth_services.dart';
import '../../common/themes.dart';
import '../../services/info_services.dart';
import '../../widgets/reuse/reusable_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget header = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Trouble with logging in?',
          style: authTitleStyle.copyWith(
            fontSize: (SizeConfig.safeBlockHorizontal * 8.3).roundToDouble(),
          ),
        ),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 2.4).roundToDouble(),
        ),
        Text(
          'Enter your email address and\nwe’ll send you a link to get back\ninto your account.',
          textAlign: TextAlign.center,
          style: GoogleFonts.abhayaLibre(
            color: authTextColor,
            fontSize: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
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
          decoration: authFieldDecoration.copyWith(
            hintText: 'Enter your email',
            prefixIcon: authIcon(Icons.mail),
          ),
        ),
      ],
    );

    Widget submitButton = ReusableButton(
      color: primaryColor,
      width: double.infinity,
      child: Text('Submit', style: authTextButtonStyle),
      height: (SizeConfig.safeBlockVertical * 8.1).roundToDouble(),
      onPressed: () async {
        if (email.text.isNotEmpty) {
          try {
            await AuthServices.resetPassword(email.text);
            showAlertDialog(
              titleText: 'Email Link Sent',
              contentText:
                  'We sent an email to ${email.text} with a link to get back into your account.',
              onPressed: () => Get.offAllNamed('/sign_in'),
            );
          } catch (e) {
            showErrorSnackbar(message: e.toString());
          }
        }
      },
    );

    Widget backButton = TextButton.icon(
      onPressed: () => Get.back(),
      icon: Container(
        height: (SizeConfig.safeBlockHorizontal * 11.11).roundToDouble(),
        width: (SizeConfig.safeBlockHorizontal * 11.11).roundToDouble(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor),
        ),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: primaryColor,
          size: (SizeConfig.safeBlockHorizontal * 6.67).roundToDouble(),
        ),
      ),
      label: Text(
        'Back to sign in',
        style: TextStyle(
          color: Colors.black,
          fontSize: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        child: Center(
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
                        (SizeConfig.safeBlockVertical * 2.6).roundToDouble(),
                  ),
                  submitButton,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 16.26).roundToDouble(),
                  ),
                  backButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

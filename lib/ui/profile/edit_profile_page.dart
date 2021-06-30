import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_services.dart';
import '../../services/info_services.dart';
import '../../services/storage_services.dart';
import '../../state/user_state.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final userC = Get.find<UserState>();
  final user = Get.arguments;
  bool isProcessed = false;
  bool isPasswordChanged = false;
  bool isPasswordChangeable = false;
  bool obscureTextPass = true;
  bool obscureTextConfirm = true;
  File img;
  final username = TextEditingController();
  final whatsApp = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    whatsApp.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  void initState() {
    super.initState();
    username.text = userC.user.displayName;
    whatsApp.text = userC.user.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPad =
        (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble();

    Widget appBar = AppBar(
      elevation: 1,
      backgroundColor: mainColor,
      centerTitle: true,
      title: Text(
        'Edit',
        style: usernameTextStyle.copyWith(color: Color(0xff2E3E5C)),
      ),
      leadingWidth: (SizeConfig.safeBlockHorizontal * 22.22).roundToDouble(),
      leading: TextButton(
        onPressed: isProcessed ? null : () => Get.back(),
        child: Text(
          'Cancel',
          style: standardStyle.copyWith(color: redColor),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            setState(() => isProcessed = true);
            if (isPasswordChangeable) {
              if (password.text.isEmpty || confirmPassword.text.isEmpty) {
                setState(() => isProcessed = false);
                showErrorSnackbar(
                  message: 'Your password field must not be empty.',
                );
              } else {
                if (password.text != confirmPassword.text) {
                  setState(() => isProcessed = false);
                  showErrorSnackbar(
                    message:
                        'Your password and confirmation password do not match.',
                  );
                } else {
                  try {
                    await AuthServices.currentUser
                        .updatePassword(password.text);
                    isPasswordChanged = true;
                  } catch (e) {
                    setState(() => isProcessed = false);
                    showErrorSnackbar(message: e.toString());
                  }
                }
              }
            }
            if (isPasswordChanged || !isPasswordChangeable) {
              await AuthServices.currentUser.updateDisplayName(username.text);
              if (img != null) {
                final uploadedLink = await StorageServices.uploadImage(img);
                await AuthServices.currentUser.updatePhotoURL(uploadedLink);
              }
              await userC.setUser(
                AuthServices.currentUser,
                phoneNumber: whatsApp.text,
              );
              setState(() => isProcessed = false);
              Get.offAllNamed('/main');
            }
          },
          child: Text(
            'Done',
            style: standardStyle.copyWith(color: primaryColor),
          ),
        ),
      ],
    );

    Widget horizontalLine = Expanded(
      child: Divider(
        color: lightGrayColor,
        height: (SizeConfig.safeBlockVertical * 0.325).roundToDouble(),
      ),
    );

    Widget editProfileLabel = Container(
      padding: EdgeInsets.only(left: horizontalPad),
      child: Row(
        children: [
          Text(
            'Edit Profile',
            style: standardStyle.copyWith(fontWeight: bold),
          ),
          SizedBox(
            width: (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
          ),
          horizontalLine,
        ],
      ),
    );

    Widget usernamePart = Row(
      children: [
        Expanded(flex: 2, child: Text('Username', style: standardStyle)),
        Expanded(
          flex: 3,
          child: TextField(
            controller: username,
            style: standardStyle,
            textInputAction: TextInputAction.next,
            decoration: editProfileDecoration,
          ),
        ),
      ],
    );

    Widget whatsAppPart = Row(
      children: [
        Expanded(flex: 2, child: Text('WhatsApp', style: standardStyle)),
        Expanded(
          flex: 3,
          child: TextField(
            controller: whatsApp,
            style: standardStyle,
            decoration: editProfileDecoration,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );

    Widget passwordOption = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Show edit password', style: standardStyle),
        Switch(
          activeColor: primaryColor,
          value: isPasswordChangeable,
          onChanged: (val) => setState(() => isPasswordChangeable = val),
        ),
      ],
    );

    Widget editPasswordLabel = Container(
      padding: EdgeInsets.only(left: horizontalPad),
      child: Row(
        children: [
          Text(
            'Edit Password',
            style: standardStyle.copyWith(fontWeight: bold),
          ),
          SizedBox(
            width: (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
          ),
          horizontalLine,
        ],
      ),
    );

    Widget passwordPart = Row(
      children: [
        Expanded(
          child: Text('Password', style: standardStyle),
        ),
        Expanded(
          child: TextField(
            controller: password,
            style: standardStyle,
            obscureText: obscureTextPass,
            textInputAction: TextInputAction.next,
            decoration: editProfileDecoration.copyWith(
              suffixIcon: IconButton(
                icon: authIcon(
                  obscureTextPass ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  obscureTextPass = !obscureTextPass;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ],
    );

    Widget confirmPasswordPart = Row(
      children: [
        Expanded(
          child: Text('Confirm Password', style: standardStyle),
        ),
        Expanded(
          child: TextField(
            controller: confirmPassword,
            style: standardStyle,
            obscureText: obscureTextConfirm,
            decoration: editProfileDecoration.copyWith(
              suffixIcon: IconButton(
                icon: authIcon(
                  obscureTextConfirm ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  obscureTextConfirm = !obscureTextConfirm;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ],
    );

    Widget passwordCompletedPart = Column(
      children: [
        editPasswordLabel,
        SizedBox(
          height: (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPad),
          child: Column(
            children: [
              passwordPart,
              SizedBox(
                height: (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
              ),
              confirmPasswordPart,
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: mainColor,
      appBar: appBar,
      body: isProcessed
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 3.25).roundToDouble(),
                  ),
                  CircleAvatar(
                    backgroundImage: img == null
                        ? user.photoURL == null
                            ? AssetImage('assets/img/profile.png')
                            : NetworkImage(user.photoURL)
                        : FileImage(img),
                    radius: (SizeConfig.safeBlockHorizontal * 16.67)
                        .roundToDouble(),
                  ),
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                  ),
                  InkWell(
                    child: Text(
                      'Change profile photo',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: medium,
                        fontSize: (SizeConfig.safeBlockHorizontal * 3.61)
                            .roundToDouble(),
                      ),
                    ),
                    onTap: () async {
                      final file = await StorageServices.getImage();
                      if (file != null) {
                        setState(() {
                          img = file;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
                  ),
                  editProfileLabel,
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPad),
                    child: Column(
                      children: [
                        usernamePart,
                        SizedBox(
                          height: (SizeConfig.safeBlockHorizontal * 4.17)
                              .roundToDouble(),
                        ),
                        whatsAppPart,
                        SizedBox(
                          height: (SizeConfig.safeBlockHorizontal * 4.17)
                              .roundToDouble(),
                        ),
                        passwordOption,
                      ],
                    ),
                  ),
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
                  ),
                  isPasswordChangeable ? passwordCompletedPart : SizedBox(),
                  SizedBox(
                    height:
                        (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello_petty/common/size_config.dart';
import 'package:hello_petty/common/themes.dart';
import 'package:hello_petty/widgets/reuse/reusable_button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showAlertDialog({
  @required String titleText,
  @required String contentText,
  @required Function onPressed,
  bool isComplicatedCase = false,
}) {
  Get.dialog(
    AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
        vertical: (SizeConfig.safeBlockVertical * 2.27).roundToDouble(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Center(child: Text(titleText, style: titleDialogStyle)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            contentText,
            textAlign: TextAlign.center,
            style: contentDialogStyle,
          ),
          SizedBox(
            height: (SizeConfig.safeBlockVertical * 2.92).roundToDouble(),
          ),
          isComplicatedCase
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customButton(
                      onPressed: () => Get.back(),
                      color: redColor,
                      text: 'No',
                    ),
                    customButton(
                        onPressed: onPressed, color: greenColor, text: 'Yes'),
                  ],
                )
              : customButton(
                  onPressed: onPressed, color: greenColor, text: 'Ok'),
        ],
      ),
    ),
  );
}

Widget customButton({
  @required Color color,
  @required String text,
  @required Function onPressed,
}) =>
    ReusableButton(
      onPressed: onPressed,
      height: (SizeConfig.safeBlockVertical * 6.5).roundToDouble(),
      width: (SizeConfig.safeBlockHorizontal * 25).roundToDouble(),
      color: color,
      radius: 20,
      child: Text(text, style: authTextButtonStyle),
    );

void showErrorSnackbar({@required String message}) {
  Get.snackbar(
    'Error',
    message,
    titleText: Text(
      'Error',
      style: TextStyle(
        color: whiteColor,
        fontWeight: bold,
        fontSize: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        color: whiteColor,
        fontWeight: light,
        fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
      ),
    ),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 1),
    snackPosition: SnackPosition.BOTTOM,
  );
}

Future<void> savePref(String key) async {
  final pref = await SharedPreferences.getInstance();

  pref.setBool(key, false);
}

Future<bool> getPref(String key) async {
  final pref = await SharedPreferences.getInstance();

  if (!pref.containsKey(key)) {
    return true;
  }

  return false;
}

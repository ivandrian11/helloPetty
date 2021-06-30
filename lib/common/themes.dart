import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './size_config.dart';

Color primaryColor = Color(0xff6852A5);
Color secondaryColor = Color(0xff9B8ACA);
Color mainColor = Color(0xffEFEFEF);
Color whiteColor = Colors.white;
Color authTextColor = Color(0xff322F44);
Color grayColor = Color(0xff828282);
Color unselectedBottomNavBarColor = Color(0xff9D9BA5);
Color redColor = Colors.red;
Color greenColor = Color(0xff00C32B);
Color lightGrayColor = Color(0xff9FA5C0);

TextStyle standardStyle = TextStyle(
  fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
);

TextStyle authTitleStyle = GoogleFonts.abhayaLibre(
  color: authTextColor,
  fontWeight: bold,
  fontSize: (SizeConfig.safeBlockHorizontal * 9.72).roundToDouble(),
);

TextStyle authSubtitleStyle = GoogleFonts.abhayaLibre(
  color: authTextColor,
  fontSize: (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
  fontWeight: medium,
);

TextStyle authLabelStyle = TextStyle(
  color: authTextColor,
  fontWeight: semiBold,
  fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
);

TextStyle authTextButtonStyle = TextStyle(
  color: whiteColor,
  fontWeight: semiBold,
  fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
);

TextStyle detailLabelStyle = TextStyle(
  fontWeight: semiBold,
  fontSize: (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
);

TextStyle titleDialogStyle = TextStyle(
  fontWeight: bold,
  color: Color(0xff3E5481),
  fontSize: (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
);

TextStyle contentDialogStyle = TextStyle(
  color: Color(0xff2E3E5C),
  fontWeight: medium,
  fontSize: (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
);

TextStyle usernameTextStyle = TextStyle(
  fontWeight: bold,
  fontSize: (SizeConfig.safeBlockHorizontal * 4.72).roundToDouble(),
);

TextStyle dropdownTextStyle = TextStyle(
  fontWeight: medium,
  fontSize: (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
);

TextStyle tabBarTextStyle = TextStyle(
  fontWeight: semiBold,
  fontSize: (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
);

TextStyle postTextStyle = TextStyle(
  fontWeight: bold,
  fontSize: (SizeConfig.safeBlockHorizontal * 4.17).roundToDouble(),
);

TextStyle popUpTextStyle = TextStyle(
  fontWeight: semiBold,
  fontSize: (SizeConfig.safeBlockHorizontal * 4.72).roundToDouble(),
);

OutlineInputBorder normalRadiusBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);

OutlineInputBorder uploadBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide(color: lightGrayColor),
);

OutlineInputBorder uploadActiveBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide(color: primaryColor),
);

Icon authIcon(IconData icon) => Icon(
      icon,
      size: (SizeConfig.safeBlockHorizontal * 6.67).roundToDouble(),
    );

Icon standardWhiteIcon(IconData icon) => Icon(
      icon,
      color: whiteColor,
      size: (SizeConfig.safeBlockHorizontal * 6.67).roundToDouble(),
    );

List<BoxShadow> containerShadow = [
  BoxShadow(
    color: Colors.black26,
    blurRadius: (SizeConfig.safeBlockVertical * 0.65).roundToDouble(),
    offset: Offset(0, (SizeConfig.safeBlockVertical * 0.65).roundToDouble()),
  ),
];

BoxDecoration uploadBoxDecoration = BoxDecoration(
  color: whiteColor,
  border: Border.all(color: lightGrayColor),
  borderRadius: BorderRadius.circular(16),
);

InputDecoration authFieldDecoration = InputDecoration(
  isDense: true,
  hintStyle: standardStyle,
  border: normalRadiusBorder,
);

InputDecoration editProfileDecoration = InputDecoration(
  isDense: true,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: lightGrayColor),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: lightGrayColor),
  ),
);

InputDecoration uploadFieldDecoration(String text) => InputDecoration(
      fillColor: whiteColor,
      filled: true,
      isDense: true,
      hintText: 'Enter your pet $text',
      hintStyle: standardStyle,
      enabledBorder: uploadBorder,
      focusedBorder: uploadActiveBorder,
    );

FontWeight light = FontWeight.w300;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

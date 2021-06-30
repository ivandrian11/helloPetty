import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../services/auth_services.dart';
import '../../services/info_services.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    tryGetData();
  }

  void tryGetData() async {
    final isFirst = await getPref('isFirst');
    Timer(Duration(seconds: 3), () {
      if (AuthServices.currentUser == null) {
        if (isFirst) {
          Get.offNamed('/boarding');
        } else {
          Get.offNamed('/sign_in');
        }
      } else {
        Get.offNamed('/main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/app.png',
              height: (SizeConfig.safeBlockVertical * 24.4).roundToDouble(),
            ),
            SizedBox(
              height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
            ),
            Text(
              'Hello Petty',
              style: GoogleFonts.abhayaLibre(
                fontWeight: bold,
                color: whiteColor,
                fontSize:
                    (SizeConfig.safeBlockHorizontal * 8.89).roundToDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

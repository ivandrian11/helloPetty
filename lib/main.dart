import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import './common/themes.dart';
import './routes.dart';
import './state/pet_state.dart';
import './state/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final userC = Get.put(UserState());
  final petC = Get.put(PetState());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.pages,
      unknownRoute: AppRoute.errorPage,
      title: 'Hello Petty',
      theme: ThemeData(
        accentColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: primaryColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionHandleColor: primaryColor,
          selectionColor: primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }
}

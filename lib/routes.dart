import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './ui/auth/forgot_password_page.dart';
import './ui/auth/sign_in_page.dart';
import './ui/auth/sign_up_page.dart';
import './ui/detail/pet_detail_page.dart';
import './ui/main/main_page.dart';
import './ui/main/other_profile_page.dart';
import './ui/main/search_page.dart';
import './ui/main/upload_page.dart';
import './ui/profile/edit_profile_page.dart';
import './ui/start/splash_page.dart';
import './ui/start/boarding_page.dart';

abstract class AppRoute {
  static final errorPage = GetPage(name: '/error', page: () => ErrorRoute());

  static final pages = [
    GetPage(
      name: '/',
      page: () => SplashPage(),
    ),
    GetPage(
      name: '/boarding',
      page: () => BoardingPage(),
    ),
    GetPage(
      name: '/sign_in',
      page: () => SignInPage(),
    ),
    GetPage(
      name: '/sign_up',
      page: () => SignUpPage(),
    ),
    GetPage(
      name: '/forgot',
      page: () => ForgotPasswordPage(),
    ),
    GetPage(
      name: '/main',
      page: () => MainPage(),
    ),
    GetPage(
      name: '/search',
      page: () => SearchPage(),
    ),
    GetPage(
      name: '/pet_detail',
      page: () => PetDetailPage(),
    ),
    GetPage(
      name: '/upload',
      page: () => UploadPage(),
    ),
    GetPage(
      name: '/profile',
      page: () => OtherProfilePage(),
    ),
    GetPage(
      name: '/edit_profil',
      page: () => EditProfilePage(),
    ),
  ];
}

class ErrorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Wrong Page',
          style: TextStyle(
            color: Colors.red,
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}

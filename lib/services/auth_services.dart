import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './info_services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signUp({
    @required String email,
    @required String password,
  }) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return user;
    } catch (e) {
      showErrorSnackbar(message: e.message);
      return null;
    }
  }

  static Future<User> signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return user;
    } catch (e) {
      showErrorSnackbar(message: e.message);
      return null;
    }
  }

  static Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User user = (await _auth.signInWithCredential(credential)).user;

      return user;
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static User get currentUser => _auth.currentUser;
}

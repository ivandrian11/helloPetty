import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_petty/models/users.dart';
import 'package:hello_petty/services/auth_services.dart';

class UserState extends GetxController {
  Users _mine;
  List<Users> allUser = [];

  final users = FirebaseFirestore.instance.collection('users');

  Users get user => _mine;

  Future<void> setUser(
    User user, {
    String displayName,
    String phoneNumber = '62',
  }) async {
    users.doc(user.uid).set({
      'displayName': displayName ?? user.displayName,
      'email': user.email,
      'id': user.uid,
      'photoURL': user.photoURL,
      'phoneNumber': phoneNumber,
    });
  }

  Future<void> getUser() async {
    DocumentSnapshot snapshot =
        await users.doc(AuthServices.currentUser.uid).get();
    final data = snapshot.data() as Map<String, dynamic>;
    _mine = Users.fromJson(data);
    update();
  }

  Future<void> getAllUser() async {
    allUser = [];
    final snapshot = await users.get();
    final datas = snapshot.docs;
    datas.forEach((data) {
      allUser.add(Users.fromJson(data.data()));
    });
    update();
  }

  Future<Users> getUserById(String id) async {
    DocumentSnapshot snapshot = await users.doc(id).get();
    final data = snapshot.data() as Map<String, dynamic>;
    final converted = Users.fromJson(data);
    return converted;
  }
}

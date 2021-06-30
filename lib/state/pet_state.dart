import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hello_petty/models/pets.dart';
import 'package:nanoid/nanoid.dart';

class PetState extends GetxController {
  List<Pets> allPet = [];
  final pets = FirebaseFirestore.instance.collection('pets');

  Future<void> getAllPet() async {
    allPet = [];
    final snapshot = await pets.get();
    final datas = snapshot.docs;
    datas.forEach((data) {
      allPet.add(Pets.fromJson(data.data()));
    });
    update();
  }

  Future<void> addPet({
    String ownerId,
    String imgUrl,
    String name,
    String gender,
    String age,
    String category,
    String location,
    String breed,
    String description,
    DateTime postedAt,
  }) async {
    String id = nanoid(20);
    await pets.doc(id).set({
      'id': id,
      'ownerId': ownerId,
      'imgUrl': imgUrl,
      'name': name,
      'gender': gender,
      'age': age,
      'category': category,
      'location': location,
      'breed': breed,
      'description': description,
      'postedAt': postedAt,
    });
  }
}

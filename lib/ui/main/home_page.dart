import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state/pet_state.dart';
import '../../state/user_state.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';
import '../../models/pets.dart';
import '../../widgets/once/search_tile.dart';
import '../../widgets/once/category_button.dart';
import '../../widgets/once/pet_container.dart';

enum category { all, cat, dog }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final petC = Get.find<PetState>();
  final userC = Get.find<UserState>();
  category selectedCategory = category.all;

  @override
  Widget build(BuildContext context) {
    Widget categoriesWidget = Container(
      padding: EdgeInsets.only(left: SizeConfig.screenWidth / 4.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryButton(
            text: 'All',
            condition: selectedCategory == category.all,
            onPressed: () {
              selectedCategory = category.all;
              setState(() {});
            },
          ),
          CategoryButton(
            text: 'Cats',
            condition: selectedCategory == category.cat,
            onPressed: () {
              selectedCategory = category.cat;
              setState(() {});
            },
          ),
          CategoryButton(
            text: 'Dogs',
            condition: selectedCategory == category.dog,
            onPressed: () {
              selectedCategory = category.dog;
              setState(() {});
            },
          ),
        ],
      ),
    );

    Widget petsCardWidget = Expanded(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            bottom: (SizeConfig.safeBlockVertical * 9.76).roundToDouble(),
          ),
          height: (SizeConfig.safeBlockVertical * 43.9).roundToDouble(),
          child: StreamBuilder<QuerySnapshot>(
            stream: selectedCategory == category.all
                ? petC.pets
                    .orderBy("postedAt", descending: true)
                    .limit(5)
                    .snapshots()
                : selectedCategory == category.cat
                    ? petC.pets
                        .where("category", isEqualTo: 'Cat')
                        .orderBy("postedAt", descending: true)
                        .limit(5)
                        .snapshots()
                    : petC.pets
                        .where("category", isEqualTo: 'Dog')
                        .orderBy("postedAt", descending: true)
                        .limit(5)
                        .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<Pets> pets = [];
                snapshot.data.docs.forEach((pet) {
                  pets.add(Pets.fromJson(pet.data() as Map<String, dynamic>));
                });

                return ListView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  children: pets.map((pet) => PetContainer(pet)).toList(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Data has not been loaded.\nPlease restart your app.',
                    style: standardStyle,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: SizeConfig.screenWidth / 4),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: (SizeConfig.safeBlockVertical * 3.25).roundToDouble() +
                        SizeConfig.safeAreaVertical),
                padding: EdgeInsets.symmetric(
                  horizontal:
                      (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchTile(
                      size: (SizeConfig.safeBlockHorizontal * 12.78)
                          .roundToDouble(),
                    ),
                    SizedBox(
                      height:
                          (SizeConfig.safeBlockVertical * 4.88).roundToDouble(),
                    ),
                    categoriesWidget,
                  ],
                ),
              ),
              petsCardWidget,
            ],
          ),
        ],
      ),
    );
  }
}

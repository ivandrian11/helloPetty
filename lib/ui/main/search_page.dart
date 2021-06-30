import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_services.dart';
import '../../state/pet_state.dart';
import '../../state/user_state.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';
import '../../models/pets.dart';
import '../../models/users.dart';
import '../../widgets/once/custom_text_field.dart';
import '../../widgets/reuse/reusable_button.dart';
import '../../widgets/once/search_result_grid.dart';
import '../../widgets/reuse/custom_tile.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final search = TextEditingController();
  final petC = Get.find<PetState>();
  final userC = Get.find<UserState>();
  bool isSearched = false;

  @override
  void dispose() {
    super.dispose();
    search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget userList(List<Users> list) {
      return Column(
        children: list
            .map(
              (user) => CustomTile(
                user: user,
                onTap: () => Get.toNamed(
                  '/profile',
                  arguments: user.id,
                ),
              ),
            )
            .toList(),
      );
    }

    Widget performUserSearch(List<Users> list) {
      List<Users> filterList = [];
      for (var item in list) {
        if (item.displayName
                .toLowerCase()
                .contains(search.text.toLowerCase()) &&
            item.displayName != userC.user.displayName) {
          filterList.add(item);
        }
      }
      return userList(filterList);
    }

    Widget petList(List<Pets> list) {
      return GridView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
        children: list.map((pet) => SearchResultGrid(pet)).toList(),
      );
    }

    Widget performPetSearch(List<Pets> list) {
      List<Pets> filterList = [];
      for (var item in list) {
        if ((item.name.toLowerCase().contains(search.text.toLowerCase()) ||
                item.breed.toLowerCase().contains(search.text.toLowerCase())) &&
            item.ownerId != AuthServices.currentUser.uid) {
          filterList.add(item);
        }
      }
      return petList(filterList);
    }

    Widget backButton = ReusableButton(
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: whiteColor,
        size: (SizeConfig.safeBlockHorizontal * 6.67).roundToDouble(),
      ),
      onPressed: () => Get.back(),
      radius: 8,
      height: (SizeConfig.safeBlockHorizontal * 12.78).roundToDouble(),
      borderColor: whiteColor,
    );

    Widget textField = CustomTextField(
      size: (SizeConfig.safeBlockHorizontal * 12.78).roundToDouble(),
      controller: search,
      onPressed: () {
        setState(() => isSearched = true);
      },
    );

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: (SizeConfig.safeBlockVertical * 3.25).roundToDouble() +
                    SizeConfig.safeAreaVertical,
                bottom: (SizeConfig.safeBlockVertical * 1.3).roundToDouble(),
              ),
              child: Row(
                children: [
                  backButton,
                  SizedBox(
                    width:
                        (SizeConfig.safeBlockHorizontal * 2.2).roundToDouble(),
                  ),
                  textField,
                ],
              ),
            ),
            isSearched
                ? Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        performUserSearch(userC.allUser),
                        performPetSearch(petC.allPet),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

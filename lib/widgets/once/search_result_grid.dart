import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';
import '../../models/pets.dart';

class SearchResultGrid extends StatelessWidget {
  final Pets pet;

  SearchResultGrid(this.pet);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        '/pet_detail',
        arguments: pet,
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: whiteColor,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Hero(
                tag: pet.imgUrl,
                child: Container(
                  margin: EdgeInsets.all(
                    (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(pet.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: TextStyle(
                        fontSize: (SizeConfig.safeBlockHorizontal * 4.4)
                            .roundToDouble(),
                      ),
                    ),
                    Image.asset(
                      pet.gender.contains('Male')
                          ? 'assets/icon/male.png'
                          : 'assets/icon/female.png',
                      color: pet.gender.contains('Male')
                          ? Colors.blueAccent
                          : Colors.redAccent,
                      width: (SizeConfig.safeBlockHorizontal * 7.2)
                          .roundToDouble(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

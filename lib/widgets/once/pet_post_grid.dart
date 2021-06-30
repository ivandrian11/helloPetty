import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../common/size_config.dart';
import '../../models/pets.dart';
import '../../common/themes.dart';

class PetPostGrid extends StatelessWidget {
  final Pets pet;

  PetPostGrid(this.pet);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        '/pet_detail',
        arguments: pet,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: (SizeConfig.safeBlockVertical * 0.81).roundToDouble(),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: whiteColor,
          boxShadow: containerShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pet.name, style: postTextStyle),
                    Text(
                      DateFormat('dd MMMM yyyy').format(pet.postedAt),
                      style: TextStyle(
                        color: lightGrayColor,
                        fontSize: (SizeConfig.safeBlockHorizontal * 3.3)
                            .roundToDouble(),
                      ),
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

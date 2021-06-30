import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';
import '../../models/pets.dart';
import '../../services/auth_services.dart';
import '../../state/user_state.dart';

class PetContainer extends StatelessWidget {
  PetContainer(this.pet);

  final Pets pet;
  final userC = Get.find<UserState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
      ),
      height: (SizeConfig.safeBlockVertical * 43.9).roundToDouble(),
      width: (SizeConfig.safeBlockHorizontal * 55.56).roundToDouble(),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: containerShadow,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 20,
            child: GestureDetector(
              onTap: () => Get.toNamed(
                '/pet_detail',
                arguments: pet,
              ),
              child: Hero(
                tag: pet.imgUrl,
                child: Container(
                  margin: EdgeInsets.all(
                    (SizeConfig.safeBlockHorizontal * 3.3).roundToDouble(),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(pet.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal:
                    (SizeConfig.safeBlockHorizontal * 3.3).roundToDouble(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          pet.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: semiBold,
                            fontSize: (SizeConfig.safeBlockHorizontal * 5.56)
                                .roundToDouble(),
                          ),
                        ),
                      ),
                      Image.asset(
                        pet.gender.contains('Male')
                            ? 'assets/icon/male.png'
                            : 'assets/icon/female.png',
                        color: pet.gender.contains('Male')
                            ? Colors.blueAccent
                            : Colors.redAccent,
                        width: (SizeConfig.safeBlockHorizontal * 8.3)
                            .roundToDouble(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Owner ID: ',
                          style: TextStyle(
                            fontSize: (SizeConfig.safeBlockHorizontal * 3.89)
                                .roundToDouble(),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              if (pet.ownerId != AuthServices.currentUser.uid) {
                                Get.toNamed(
                                  '/profile',
                                  arguments: pet.ownerId,
                                );
                              }
                            },
                            child: Text(
                              pet.ownerId,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize:
                                    (SizeConfig.safeBlockHorizontal * 3.89)
                                        .roundToDouble(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

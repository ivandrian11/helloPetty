import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/users.dart';
import '../../services/auth_services.dart';
import '../../services/info_services.dart';
import '../../state/pet_state.dart';
import '../../state/user_state.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';
import '../../models/pets.dart';
import '../../widgets/reuse/reusable_button.dart';

class PetDetailPage extends StatefulWidget {
  @override
  _PetDetailPageState createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  final pet = Get.arguments as Pets;
  final petC = Get.find<PetState>();
  final userC = Get.find<UserState>();
  bool isLoading = false;
  Users owner;

  void getData(String id) async {
    owner = await userC.getUserById(id);
  }

  @override
  Widget build(BuildContext context) {
    getData(pet.ownerId);
    bool isMe = AuthServices.currentUser.uid == pet.ownerId;

    Widget purpleBackground = Container(
      margin: EdgeInsets.only(left: SizeConfig.screenWidth / 4),
      color: secondaryColor,
    );

    Widget imageOnly = Hero(
      tag: pet.imgUrl,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(pet.imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    Widget smallButtonOnImage({
      @required Function onPressed,
      @required IconData icon,
    }) =>
        ReusableButton(
          color: whiteColor.withOpacity(0.4),
          onPressed: onPressed,
          radius: 8,
          child: standardWhiteIcon(icon),
          height: (SizeConfig.safeBlockVertical * 8.1).roundToDouble(),
        );

    Widget imageCompleted = Expanded(
      flex: 3,
      child: Stack(
        children: [
          imageOnly,
          Container(
            padding: EdgeInsets.all(
              (SizeConfig.safeBlockHorizontal * 2.2).roundToDouble(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallButtonOnImage(
                  onPressed: isLoading ? null : () => Get.back(),
                  icon: Icons.arrow_back_ios_outlined,
                ),
                SizedBox(),
              ],
            ),
          )
        ],
      ),
    );

    Widget bottomActionButton({
      @required Function onPressed,
      @required IconData icon,
      @required String text,
      double width,
    }) =>
        ReusableButton(
          color: primaryColor,
          height: (SizeConfig.safeBlockVertical * 8.1).roundToDouble(),
          width:
              width ?? (SizeConfig.safeBlockHorizontal * 34.72).roundToDouble(),
          radius: 15,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: whiteColor,
                size: (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
              ),
              SizedBox(
                width: (SizeConfig.safeBlockHorizontal * 1.1).roundToDouble(),
              ),
              Text(text, style: authTextButtonStyle),
            ],
          ),
        );

    Widget petCoreData = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: '${pet.name}, ',
                  style: detailLabelStyle.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '${pet.age}',
                      style: standardStyle.copyWith(fontWeight: light),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: (SizeConfig.safeBlockVertical * 0.65).roundToDouble(),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size:
                        (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
                  ),
                  Text(
                    pet.location,
                    style: TextStyle(
                      fontSize: (SizeConfig.safeBlockHorizontal * 3.3)
                          .roundToDouble(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Image.asset(
          pet.gender.contains('Male')
              ? 'assets/icon/male.png'
              : 'assets/icon/female.png',
          color: pet.gender.contains('Male')
              ? Colors.blueAccent
              : Colors.redAccent,
          width: (SizeConfig.safeBlockHorizontal * 12.5).roundToDouble(),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          purpleBackground,
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: (SizeConfig.safeBlockVertical * 3.25).roundToDouble() +
                  SizeConfig.safeAreaVertical,
              bottom: (SizeConfig.safeBlockVertical * 3.25).roundToDouble(),
              left: (SizeConfig.safeBlockHorizontal * 8.3).roundToDouble(),
              right: (SizeConfig.safeBlockHorizontal * 8.3).roundToDouble(),
            ),
            padding: EdgeInsets.all(
              (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: containerShadow,
            ),
            child: Column(
              children: [
                imageCompleted,
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: (SizeConfig.safeBlockVertical * 1.6)
                                  .roundToDouble(),
                            ),
                            petCoreData,
                            SizedBox(
                              height: (SizeConfig.safeBlockVertical * 1.6)
                                  .roundToDouble(),
                            ),
                            Text('Breed', style: detailLabelStyle),
                            Text(pet.breed, style: standardStyle),
                            SizedBox(
                              height: (SizeConfig.safeBlockVertical * 1.6)
                                  .roundToDouble(),
                            ),
                            Text('Description', style: detailLabelStyle),
                            Flexible(
                              child: Text(
                                pet.description,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: standardStyle,
                                maxLines: (SizeConfig.safeBlockVertical * 0.65)
                                    .round(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      isMe
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : bottomActionButton(
                                        icon: CupertinoIcons.trash,
                                        text: 'Delete',
                                        onPressed: () => showAlertDialog(
                                          titleText: 'Confirmation',
                                          contentText:
                                              'Are you sure want to delete?',
                                          isComplicatedCase: true,
                                          onPressed: () async {
                                            Get.back();
                                            setState(() => isLoading = true);
                                            await petC.pets
                                                .doc(pet.id)
                                                .delete();
                                            setState(() => isLoading = false);
                                            Get.offAllNamed('/main');
                                          },
                                        ),
                                      ),
                                bottomActionButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => Get.toNamed(
                                            '/upload',
                                            arguments: pet,
                                          ),
                                  icon: Icons.edit,
                                  text: 'Edit',
                                ),
                              ],
                            )
                          : bottomActionButton(
                              icon: Icons.call,
                              text: 'Contact Me',
                              width: double.infinity,
                              onPressed: () async => await launch(
                                "https://wa.me/${owner.phoneNumber}?text=Halo ${owner.displayName}, saya tertarik dengan si ${pet.name}.",
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

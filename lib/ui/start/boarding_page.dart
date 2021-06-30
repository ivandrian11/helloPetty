import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../services/info_services.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';

class BoardingPage extends StatefulWidget {
  @override
  _BoardingPageState createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  int currentState = 0;

  List<String> descriptions = [
    'Help those pets deserve adoption.\nEvery pet needs a loving home.',
    'Find a lifesaver for your pet.\nAdopt your pet and give them love.',
    'Join us for pets adoption and\ngive them a loving home.',
  ];

  @override
  Widget build(BuildContext context) {
    Widget paginationClips = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PaginationClip(currentState == 0),
        SizedBox(
          width: (SizeConfig.safeBlockHorizontal * 2.2).roundToDouble(),
        ),
        PaginationClip(currentState == 1),
        SizedBox(
          width: (SizeConfig.safeBlockHorizontal * 2.2).roundToDouble(),
        ),
        PaginationClip(currentState == 2),
      ],
    );

    Widget paginationButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentState != 0
            ? GestureDetector(
                onTap: () {
                  currentState--;
                  setState(() {});
                },
                child: Container(
                  width: SizeConfig.screenWidth / 3,
                  height: (SizeConfig.safeBlockVertical * 9.76).roundToDouble(),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: bold,
                        fontSize: (SizeConfig.safeBlockHorizontal * 5)
                            .roundToDouble(),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(),
        GestureDetector(
          onTap: () async {
            if (currentState != 2) {
              currentState++;
              setState(() {});
            } else {
              await savePref('isFirst');
              Get.offNamed('/sign_in');
            }
          },
          child: Container(
            width: SizeConfig.screenWidth / 3,
            height: (SizeConfig.safeBlockVertical * 9.76).roundToDouble(),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(32),
              ),
            ),
            child: Center(
              child: Text(
                currentState != 2 ? 'Next' : 'Start',
                style: TextStyle(
                  color: primaryColor,
                  fontSize:
                      (SizeConfig.safeBlockHorizontal * 5).roundToDouble(),
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/img/illus$currentState.svg',
            height: SizeConfig.screenHeight / 3,
          ),
          SizedBox(
            height: (SizeConfig.safeBlockVertical * 5.2).roundToDouble(),
          ),
          Text(
            descriptions[currentState],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
              fontWeight: medium,
              fontSize: (SizeConfig.safeBlockVertical * 2.27).roundToDouble(),
            ),
          ),
          SizedBox(
            height: (SizeConfig.safeBlockVertical * 5.2).roundToDouble(),
          ),
          paginationClips,
          SizedBox(
            height: (SizeConfig.safeBlockVertical * 5.2).roundToDouble(),
          ),
          paginationButtons,
        ],
      ),
    );
  }
}

class PaginationClip extends StatelessWidget {
  final bool isActive;

  PaginationClip(this.isActive);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive
          ? (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble()
          : (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
      height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
      decoration: BoxDecoration(
        color: isActive ? secondaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: secondaryColor),
      ),
    );
  }
}

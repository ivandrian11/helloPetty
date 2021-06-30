import 'package:flutter/material.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';

class ClickableContainer extends StatelessWidget {
  final Function onTap;
  final String imgUrl;
  final Color color;

  ClickableContainer({
    @required this.onTap,
    @required this.imgUrl,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (SizeConfig.safeBlockHorizontal * 42.2).roundToDouble(),
        height: (SizeConfig.safeBlockVertical * 9.1).roundToDouble(),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primaryColor),
          boxShadow: containerShadow,
        ),
        child: Center(
          child: Image.asset(
            imgUrl,
            color: color,
            width: (SizeConfig.safeBlockHorizontal * 12.5).roundToDouble(),
          ),
        ),
      ),
    );
  }
}

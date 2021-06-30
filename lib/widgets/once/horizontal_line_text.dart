import 'package:flutter/material.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';

class HorizontalLineText extends StatelessWidget {
  final String text;

  HorizontalLineText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Divider(color: grayColor),
            margin: EdgeInsets.symmetric(
              horizontal:
                  (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
          ),
        ),
        Expanded(
          child: Container(
            child: Divider(color: grayColor),
            margin: EdgeInsets.symmetric(
              horizontal:
                  (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double size;
  final Function onPressed;

  CustomTextField({
    @required this.controller,
    @required this.onPressed,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: size,
        padding: EdgeInsets.only(
          left: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
          top: 1,
          right: 1,
          bottom: 1,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: (SizeConfig.safeBlockHorizontal * 1.1).roundToDouble(),
                ),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  style: TextStyle(
                    fontSize:
                        (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Persia',
                    hintStyle: TextStyle(
                      fontSize: (SizeConfig.safeBlockHorizontal * 4.4)
                          .roundToDouble(),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.search_outlined,
                  color: whiteColor,
                  size: (SizeConfig.safeBlockHorizontal * 6.67).roundToDouble(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

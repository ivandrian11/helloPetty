import 'package:flutter/material.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';

class CategoryButton extends StatelessWidget {
  final Function onPressed;
  final bool condition;
  final String text;

  CategoryButton({
    @required this.condition,
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          condition ? primaryColor : secondaryColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: medium,
          fontSize: (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final Widget child;
  final double width;
  final double height;
  final double radius;
  final Color borderColor;
  final double elevation;

  ReusableButton({
    @required this.child,
    @required this.onPressed,
    @required this.height,
    this.color,
    this.borderColor,
    this.elevation,
    this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: color,
      elevation: elevation ?? 0,
      onPressed: onPressed,
      child: child,
      constraints: BoxConstraints.tightFor(
        width: width ?? height,
        height: height,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
    );
  }
}

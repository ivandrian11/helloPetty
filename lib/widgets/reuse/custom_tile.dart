import 'package:flutter/material.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';
import '../../models/users.dart';

class CustomTile extends StatelessWidget {
  final Users user;
  final Function onTap;

  CustomTile({this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: whiteColor,
          backgroundImage: NetworkImage(user.photoURL),
          radius: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
        ),
        title: Text(
          user.displayName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: semiBold,
            fontSize: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.black,
          size: (SizeConfig.safeBlockHorizontal * 6.67).roundToDouble(),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
        ),
      ),
    );
  }
}

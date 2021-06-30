import 'package:flutter/material.dart';
import '../../common/size_config.dart';
import '../../common/themes.dart';

class SearchTile extends StatelessWidget {
  final double size;

  SearchTile({@required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/search'),
      child: Container(
        padding: EdgeInsets.only(
          left: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
          top: 1,
          right: 1,
          bottom: 1,
        ),
        height: size,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search',
              style: TextStyle(
                fontSize: (SizeConfig.safeBlockHorizontal * 4.4).roundToDouble(),
              ),
            ),
            Container(
              child: standardWhiteIcon(Icons.search_outlined),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

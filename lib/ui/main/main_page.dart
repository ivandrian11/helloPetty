import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_petty/services/info_services.dart';
import '../../common/size_config.dart';
import '../../state/pet_state.dart';
import '../../state/user_state.dart';
import '../../common/themes.dart';
import '../../ui/main/home_page.dart';
import '../../ui/main/profile_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final userC = Get.find<UserState>();
  final petC = Get.find<PetState>();
  bool isGet = false;
  int bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    getDataNeeded();
  }

  void getDataNeeded() async {
    await userC.getUser();
    await userC.getAllUser();
    await petC.getAllPet();
    setState(() => isGet = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGet
          ? bottomNavIndex == 0
              ? HomePage()
              : ProfilePage()
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: (SizeConfig.safeBlockHorizontal * 2.78).roundToDouble(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: (SizeConfig.safeBlockHorizontal * 6.94).roundToDouble(),
          ),
          height: (SizeConfig.safeBlockVertical * 9.76).roundToDouble(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomNavBarItem(
                activeCondition: bottomNavIndex == 0,
                icon: Icons.home,
                title: 'Home',
                onPressed: () {
                  setState(() {
                    bottomNavIndex = 0;
                  });
                },
              ),
              CustomNavBarItem(
                activeCondition: bottomNavIndex == 1,
                icon: Icons.person,
                title: 'Profile',
                onPressed: () {
                  setState(() {
                    bottomNavIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: (SizeConfig.safeBlockHorizontal * 15.56).roundToDouble(),
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            child: standardWhiteIcon(Icons.add),
            onPressed: () {
              if (userC.user.phoneNumber == '62') {
                showErrorSnackbar(
                  message: 'You must add your WA number before you can post. Go to your profile.',
                );
              } else {
                Get.toNamed('/upload');
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomNavBarItem extends StatelessWidget {
  final bool activeCondition;
  final IconData icon;
  final String title;
  final Function onPressed;

  CustomNavBarItem({
    @required this.activeCondition,
    @required this.icon,
    @required this.onPressed,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: onPressed,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: activeCondition ? primaryColor : whiteColor,
          height: (SizeConfig.safeBlockVertical * 5.85).roundToDouble(),
          minWidth: (SizeConfig.safeBlockHorizontal * 22.22).roundToDouble(),
          child: Row(
            children: [
              Icon(
                icon,
                size: (SizeConfig.safeBlockHorizontal * 6.67).roundToDouble(),
                color:
                    activeCondition ? whiteColor : unselectedBottomNavBarColor,
              ),
              SizedBox(
                width: (SizeConfig.safeBlockHorizontal * 1.1).roundToDouble(),
              ),
              Text(
                title,
                style: TextStyle(
                  color: activeCondition
                      ? whiteColor
                      : unselectedBottomNavBarColor,
                  fontSize:
                      (SizeConfig.safeBlockHorizontal * 3.89).roundToDouble(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

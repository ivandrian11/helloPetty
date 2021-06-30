import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/size_config.dart';
import '../../services/auth_services.dart';
import '../../state/pet_state.dart';
import '../../state/user_state.dart';
import '../../services/info_services.dart';
import '../../common/themes.dart';
import '../../models/pets.dart';
import '../../widgets/once/pet_post_grid.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userC = Get.find<UserState>();
  final petC = Get.find<PetState>();

  @override
  Widget build(BuildContext context) {
    final user = userC.user;

    Widget popMenu = Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.list,
          size: (SizeConfig.safeBlockHorizontal * 9.72).roundToDouble(),
        ),
        onSelected: (String result) {
          switch (result) {
            case 'edit':
              Get.toNamed(
                '/edit_profil',
                arguments: user,
              );
              break;
            case 'log_out':
              showAlertDialog(
                titleText: 'Confirmation',
                isComplicatedCase: true,
                contentText: 'Are you sure want to log out?',
                onPressed: () async {
                  await AuthServices.signOut();
                  Get.offAllNamed('/sign_in');
                },
              );
              break;
            default:
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem<String>(
            value: 'edit',
            child: Text('Edit', style: popUpTextStyle),
          ),
          PopupMenuItem<String>(
            value: 'log_out',
            child: Text('Log Out', style: popUpTextStyle),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            popMenu,
            CircleAvatar(
              backgroundImage: user.photoURL == null
                  ? AssetImage('assets/img/profile.png')
                  : NetworkImage(user.photoURL),
              radius: (SizeConfig.safeBlockHorizontal * 16.67).roundToDouble(),
            ),
            SizedBox(
              height: (SizeConfig.safeBlockVertical * 1.95).roundToDouble(),
            ),
            Text('${user.displayName}', style: usernameTextStyle),
            SizedBox(
              height: (SizeConfig.safeBlockVertical * 1.95).roundToDouble(),
            ),
            Divider(
              color: primaryColor,
              height: 0,
              thickness:
                  (SizeConfig.safeBlockHorizontal * 0.56).roundToDouble(),
            ),
            Expanded(
              child: StreamBuilder(
                stream: petC.pets
                    .where(
                      'ownerId',
                      isEqualTo: AuthServices.currentUser.uid,
                    )
                    .orderBy('postedAt', descending: true)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    List<Pets> pets = [];

                    snapshot.data.docs.forEach((pet) {
                      pets.add(
                          Pets.fromJson(pet.data() as Map<String, dynamic>));
                    });
                    return GridView(
                      padding: EdgeInsets.all(
                        (SizeConfig.safeBlockHorizontal * 2.2).roundToDouble(),
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      children: pets.map((pet) => PetPostGrid(pet)).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Data has not been loaded.\nPlease restart your app.',
                        style: standardStyle,
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

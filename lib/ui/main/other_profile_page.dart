import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_petty/models/users.dart';
import 'package:hello_petty/state/pet_state.dart';
import 'package:hello_petty/state/user_state.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';
import '../../models/pets.dart';
import '../../widgets/once/pet_post_grid.dart';

class OtherProfilePage extends StatefulWidget {
  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  final id = Get.arguments as String;
  final userC = Get.find<UserState>();
  final petC = Get.find<PetState>();
  bool isLoaded = false;
  Users owner;

  void getData(String id) async {
    owner = await userC.getUserById(id);
    setState(() => isLoaded = true);
  }

  @override
  void initState() {
    super.initState();
    getData(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: isLoaded
          ? SafeArea(
              child: Column(
                children: [
                  SizedBox(height: (SizeConfig.safeBlockVertical * 6.5).roundToDouble(),),
                  CircleAvatar(
                    backgroundImage: owner.photoURL == null
                        ? AssetImage('assets/img/profile.png')
                        : NetworkImage(owner.photoURL),
                    radius: (SizeConfig.safeBlockHorizontal * 16.67).roundToDouble(),
                  ),
                  SizedBox(height: (SizeConfig.safeBlockVertical * 1.95).roundToDouble(),),
                  Text('${owner.displayName}', style: usernameTextStyle),
                  SizedBox(height: (SizeConfig.safeBlockVertical * 1.95).roundToDouble(),),
                  Divider(
                    color: primaryColor,
                    height: 0,
                    thickness: (SizeConfig.safeBlockHorizontal * 0.56).roundToDouble(),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: petC.pets
                          .where(
                            'ownerId',
                            isEqualTo: id,
                          )
                          .orderBy('postedAt', descending: true)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          List<Pets> pets = [];
                          List<String> petsId = [];

                          snapshot.data.docs.forEach((pet) {
                            petsId.add(pet.id);
                            pets.add(
                              Pets.fromJson(pet.data() as Map<String, dynamic>),
                            );
                          });

                          return GridView(
                            padding: EdgeInsets.all(8),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            children:
                                pets.map((pet) => PetPostGrid(pet)).toList(),
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
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

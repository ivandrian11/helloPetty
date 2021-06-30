import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../services/storage_services.dart';
import '../../state/pet_state.dart';
import '../../common/themes.dart';
import '../../common/size_config.dart';
import '../../models/pets.dart';
import '../../services/auth_services.dart';
import '../../services/info_services.dart';
import '../../widgets/once/clickable_container.dart';
import '../../widgets/reuse/reusable_button.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final petC = Get.find<PetState>();
  final pet = Get.arguments as Pets;
  bool isLoading = false;
  File img;
  String choosenAge;
  String imgUrl;
  bool isCat = true;
  bool isMale = true;
  List<String> ageOption = ['month', 'year'];
  final name = TextEditingController();
  final age = TextEditingController();
  final breed = TextEditingController();
  final location = TextEditingController();
  final description = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    age.dispose();
    breed.dispose();
    location.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (pet != null) {
      name.text = pet.name;
      age.text = pet.age.split(' ')[0];
      breed.text = pet.breed;
      location.text = pet.location;
      description.text = pet.description;
      choosenAge = pet.age.split(' ')[1];
      isCat = pet.category.contains('Cat') ? true : false;
      isMale = pet.gender.contains('Male') ? true : false;
      imgUrl = pet.imgUrl;
    }

    TextStyle authLabelStyleUpd = authLabelStyle.copyWith(
      fontSize: 17,
    );

    Widget galleryPart = GestureDetector(
      onTap: () async {
        final file = await StorageServices.getImage();
        if (file != null) {
          setState(() {
            img = file;
          });
        }
      },
      child: Container(
        width: double.infinity,
        decoration: uploadBoxDecoration,
        height: (SizeConfig.safeBlockVertical * 26.02).roundToDouble(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            img == null
                ? pet == null
                    ? SvgPicture.asset(
                        'assets/icon/gallery.svg',
                        height: (SizeConfig.safeBlockVertical * 11.38)
                            .roundToDouble(),
                      )
                    : Image.network(
                        imgUrl,
                        height: (SizeConfig.safeBlockVertical * 11.38)
                            .roundToDouble(),
                      )
                : Image.file(
                    img,
                    height:
                        (SizeConfig.safeBlockVertical * 11.38).roundToDouble(),
                  ),
            SizedBox(
              height: (SizeConfig.safeBlockVertical * 1.95).roundToDouble(),
            ),
            Text(
              img == null && pet == null ? 'Add Photo' : 'Change Photo',
              style: postTextStyle,
            ),
            SizedBox(
              height: (SizeConfig.safeBlockVertical * 1.3).roundToDouble(),
            ),
            Text(
              '(up to 12 Mb)',
              style: TextStyle(
                color: lightGrayColor,
                fontWeight: medium,
                fontSize:
                    (SizeConfig.safeBlockHorizontal * 3.3).roundToDouble(),
              ),
            ),
          ],
        ),
      ),
    );

    Widget inputNamePart = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name', style: authLabelStyleUpd),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
        ),
        TextField(
          controller: name,
          style: standardStyle,
          textInputAction: TextInputAction.next,
          decoration: uploadFieldDecoration('name'),
        ),
      ],
    );

    Widget dropdownButton = DropdownButton<String>(
      onChanged: (value) => setState(() => choosenAge = value),
      underline: SizedBox(),
      value: choosenAge,
      items: ageOption
          .map((value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: contentDialogStyle,
              )))
          .toList(),
      style: contentDialogStyle,
      hint: Text('Select', style: contentDialogStyle),
      isExpanded: true,
    );

    Widget inputAgePart = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Age', style: authLabelStyleUpd),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: age,
                style: standardStyle,
                decoration: uploadFieldDecoration('age'),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: (SizeConfig.safeBlockHorizontal * 1.67).roundToDouble(),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      (SizeConfig.safeBlockHorizontal * 3.3).roundToDouble(),
                ),
                decoration: uploadBoxDecoration,
                child: dropdownButton,
              ),
            ),
          ],
        ),
      ],
    );

    Widget inputCategoryGenderPart = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories', style: authLabelStyleUpd),
            SizedBox(
              height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
            ),
            ClickableContainer(
              onTap: () => setState(() => isCat = !isCat),
              imgUrl: isCat ? 'assets/icon/cat.png' : 'assets/icon/dog.png',
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gender', style: authLabelStyleUpd),
            SizedBox(
              height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
            ),
            ClickableContainer(
              onTap: () => setState(() => isMale = !isMale),
              color: isMale ? Colors.blueAccent : Colors.redAccent,
              imgUrl:
                  isMale ? 'assets/icon/male.png' : 'assets/icon/female.png',
            ),
          ],
        ),
      ],
    );

    Widget inputBreedPart = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Breed', style: authLabelStyleUpd),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
        ),
        TextField(
          controller: breed,
          style: standardStyle,
          textInputAction: TextInputAction.next,
          decoration: uploadFieldDecoration('breed'),
        ),
      ],
    );

    Widget inputLocationPart = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: authLabelStyleUpd),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
        ),
        TextField(
          controller: location,
          style: standardStyle,
          textInputAction: TextInputAction.next,
          decoration: uploadFieldDecoration('location'),
        ),
      ],
    );

    Widget inputDescriptionPart = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: authLabelStyleUpd),
        SizedBox(
          height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
        ),
        TextField(
          controller: description,
          style: standardStyle,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: uploadFieldDecoration('description'),
        ),
      ],
    );

    Widget submitButton = isLoading
        ? Center(child: CircularProgressIndicator())
        : ReusableButton(
            onPressed: pet == null
                ? () {
                    if (name.text.isEmpty ||
                        age.text.isEmpty ||
                        breed.text.isEmpty ||
                        location.text.isEmpty ||
                        description.text.isEmpty ||
                        choosenAge == null ||
                        img == null) {
                      showErrorSnackbar(
                          message: 'Your fields must not be empty.');
                    } else {
                      showAlertDialog(
                          titleText: 'Confirmation',
                          contentText: 'Are you sure to continue?',
                          isComplicatedCase: true,
                          onPressed: () async {
                            setState(() => isLoading = true);
                            Get.back();
                            final uploadedLink =
                                await StorageServices.uploadImage(img);
                            await petC.addPet(
                              age: '${age.text} $choosenAge',
                              breed: breed.text,
                              category: isCat ? 'Cat' : 'Dog',
                              description: description.text,
                              gender: isMale ? 'Male' : 'Female',
                              imgUrl: uploadedLink,
                              location: location.text,
                              name: name.text,
                              ownerId: AuthServices.currentUser.uid,
                              postedAt: DateTime.now(),
                            );
                            setState(() => isLoading = false);
                            Get.offAllNamed('/main');
                          });
                    }
                  }
                : () async {
                    showAlertDialog(
                        titleText: 'Confirmation',
                        contentText: 'Are you sure to continue?',
                        isComplicatedCase: true,
                        onPressed: () async {
                          setState(() => isLoading = true);
                          Get.back();
                          if (img != null) {
                            final uploadedLink =
                                await StorageServices.uploadImage(img);
                            await petC.pets.doc(pet.id).update({
                              'imgUrl': uploadedLink,
                            });
                          }
                          await petC.pets.doc(pet.id).update({
                            'age': '${age.text} $choosenAge',
                            'breed': breed.text,
                            'category': isCat ? 'Cat' : 'Dog',
                            'description': description.text,
                            'gender': isMale ? 'Male' : 'Female',
                            'location': location.text,
                            'name': name.text,
                          });
                          setState(() => isLoading = false);
                          Get.offAllNamed('/main');
                        });
                  },
            color: primaryColor,
            width: double.infinity,
            height: (SizeConfig.safeBlockVertical * 8.1).roundToDouble(),
            radius: 30,
            child: Text(
              pet == null ? 'Submit' : 'Update',
              style: authTextButtonStyle,
            ),
          );

    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              (SizeConfig.safeBlockHorizontal * 5.56).roundToDouble(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: isLoading ? null : () => Get.back(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: redColor,
                      fontWeight: bold,
                      fontSize: (SizeConfig.safeBlockHorizontal * 4.72)
                          .roundToDouble(),
                    ),
                  ),
                ),
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 3.25).roundToDouble(),
                ),
                galleryPart,
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                ),
                inputNamePart,
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                ),
                inputAgePart,
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                ),
                inputCategoryGenderPart,
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                ),
                inputBreedPart,
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                ),
                inputLocationPart,
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 1.6).roundToDouble(),
                ),
                inputDescriptionPart,
                SizedBox(
                  height: (SizeConfig.safeBlockVertical * 2.6).roundToDouble(),
                ),
                submitButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

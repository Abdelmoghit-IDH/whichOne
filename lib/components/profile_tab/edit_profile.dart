import 'dart:io';
import 'package:azedpolls/models/gender_model.dart';
import 'package:azedpolls/models/user_model.dart';
import 'package:azedpolls/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../choose_image.dart';
import '../custom_radio.dart';
import 'package:path/path.dart' as Path;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final picker = ImagePicker();
  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  File? _coverImage;
  File? _profilImage;
  int? _selectedGender;
  String? _imageUrl;
  String? _coverUrl;

  List<Gender> genders = [];

  Future coverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _coverImage = File(pickedFile!.path);
    });
  }

  Future profilImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilImage = File(pickedFile!.path);
    });
  }

  rightGender(String gender) {
    switch (gender) {
      case "male":
        return 0;
      case "female":
        return 1;
      default:
        return 0;
    }
  }

  gender() {
    if (_selectedGender == 0) {
      genders = [
        Gender("Male", MdiIcons.genderMale, true),
        Gender("Female", MdiIcons.genderFemale, false),
      ];
    } else {
      genders = [
        Gender("Male", MdiIcons.genderMale, false),
        Gender("Female", MdiIcons.genderFemale, true),
      ];
    }
  }

  selectedGender() {
    switch (_selectedGender) {
      case 0:
        return "male";
      case 1:
        return "female";
      default:
        return "male";
    }
  }

  Future uploadImageToFirebase(
      File imageFile, bool isCover, String cloudFolder) async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    String fileName = Path.basename(imageFile.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(cloudFolder)
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fileName},
    );
    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putFile(File(imageFile.path), metadata);
    Future.value(uploadTask)
        .then((value) => {print("Upload file path ${value.ref.fullPath}")})
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});

    uploadTask.whenComplete(() async {
      try {
        if (isCover) {
          UserModel userModel = new UserModel(
            authNotifier.user.uid!,
            {
              'fullname': fullnameController.text,
              'username': usernameController.text,
              'email': emailController.text,
              'gender': selectedGender(),
              'coverUrl': await ref.getDownloadURL(),
            },
          );
          await userModel.update();
          authNotifier.user = userModel;
        } else {
          UserModel userModel = new UserModel(
            authNotifier.user.uid!,
            {
              'fullname': fullnameController.text,
              'username': usernameController.text,
              'email': emailController.text,
              'gender': selectedGender(),
              'imageUrl': await ref.getDownloadURL(),
            },
          );
          await userModel.update();
          authNotifier.user = userModel;
        }
      } catch (onError) {
        print("Error $onError");
      }
      print("_coverUrl $_coverUrl");
    });
  }

  @override
  void initState() {
    super.initState();
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    usernameController.text = authNotifier.user.username!;
    fullnameController.text = authNotifier.user.fullname!;
    emailController.text = authNotifier.user.email!;
    _selectedGender = rightGender(authNotifier.user.gender!);
    gender();
    _imageUrl = authNotifier.user.imageUrl;
    _coverUrl = authNotifier.user.coverUrl;
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 230,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _coverImage == null
                                      ? NetworkImage(
                                          authNotifier.user.coverUrl!)
                                      : FileImage(_coverImage!)
                                          as ImageProvider,
                                ),
                              ),
                              child: ListTile(
                                leading: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                trailing: TextButton(
                                  onPressed: () async {
                                    if (_coverImage != null &&
                                        _profilImage != null) {
                                      uploadImageToFirebase(
                                          _coverImage!, true, "coverImages");
                                      uploadImageToFirebase(
                                          _profilImage!, false, "profilImages");
                                    }
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ChangeCover(
                              onPressed: coverImage,
                            )
                          ],
                        ),
                        SizedBox(height: 60)
                      ],
                    ),
                    ChangePicProfil(
                      profilImage: _profilImage,
                      onPressed: () {
                        chooseImage(context);
                      },
                      imageUrl: _imageUrl,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Profile",
                        style: TextStyle(
                          fontSize: 23,
                        )),
                  ),
                ),
                Divider(color: Colors.black),
                TextfieldEditProfil(
                  leading: "Username",
                  hintText: "Enter your Username",
                  controller: usernameController,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  child: Divider(color: Colors.black),
                ),
                TextfieldEditProfil(
                  leading: "FullName",
                  hintText: "Enter your FullName",
                  controller: fullnameController,
                ),
                SizedBox(height: 10),
                Divider(color: Colors.black),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "INFO",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.black),
                TextfieldEditProfil(
                  leading: "Email",
                  hintText: "Enter your Email",
                  controller: emailController,
                ),
                SizedBox(height: 25),
                Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: genders.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.pinkAccent,
                          onTap: () {
                            setState(() {
                              _selectedGender = index;
                              genders.forEach(
                                  (gender) => gender.isSelected = false);
                              genders[index].isSelected = true;
                            });
                          },
                          child: CustomRadio(genders[index]),
                        );
                      }),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePicProfil extends StatelessWidget {
  const ChangePicProfil({
    Key? key,
    required File? profilImage,
    required this.onPressed,
    required this.imageUrl,
  })  : _profilImage = profilImage,
        super(key: key);

  final File? _profilImage;
  final VoidCallback? onPressed;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170,
      right: 165,
      child: Card(
        color: Color(0xFFffd6da),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(180),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Stack(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.bottomCenter,
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 75,
                    backgroundImage: _profilImage == null
                        ? NetworkImage(imageUrl!)
                        : FileImage(_profilImage!) as ImageProvider,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: Color(0xFFffd6da),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextfieldEditProfil extends StatelessWidget {
  const TextfieldEditProfil({
    required this.leading,
    this.controller,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final String? leading, hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "$leading:",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: TextField(
                  controller: controller,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFFdc8c97),
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChangeCover extends StatelessWidget {
  const ChangeCover({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.image_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
            Text(
              "Tap here to change to your cover photo",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

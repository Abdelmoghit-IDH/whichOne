import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final picker = ImagePicker();
  File? _coverImage;
  File? _profilImage;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                                  ? MemoryImage(kTransparentImage)
                                  : FileImage(_coverImage!) as ImageProvider,
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
                              onPressed: () {},
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
                  onPressed: profilImage,
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Divider(color: Colors.black),
            ),
            TextfieldEditProfil(
              leading: "FullName",
              hintText: "Enter your FullName",
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("INFO",
                    style: TextStyle(
                      fontSize: 23,
                    )),
              ),
            ),
            Divider(color: Colors.black),
            TextfieldEditProfil(
              leading: "Email",
              hintText: "Enter your Email",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Divider(color: Colors.black),
            ),
            TextfieldEditProfil(
              leading: "Gender",
              hintText: "Enter your Gender",
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black),
          ],
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
  })  : _profilImage = profilImage,
        super(key: key);

  final File? _profilImage;
  final VoidCallback? onPressed;

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
                        ? AssetImage(
                            'assets/images/profile.png',
                          )
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

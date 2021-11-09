import 'dart:io';
import 'package:azedpolls/components/custom_radio.dart';
import 'package:azedpolls/models/gender_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:azedpolls/components/button.dart';
import 'package:azedpolls/components/circular_indicator.dart';
import 'package:azedpolls/components/custom_appbar.dart';
import 'package:azedpolls/components/input_text.dart';
import 'package:azedpolls/services/auth_services.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../const.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final displayNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int? _selectedGender;
  bool _isLoading = false;

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

  List<Gender> genders = [
    Gender("Male", MdiIcons.genderMale, false),
    Gender("Female", MdiIcons.genderFemale, false),
  ];

  void toggleSpinner() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: CircularIndicator(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: '',
          iconLeading: FontAwesomeIcons.arrowLeft,
          iconTrailing: IconData(2),
          onPressLeading: () => Navigator.pop(context),
          onPressTrailing: () {},
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFffd6da),
                        Color(0xFFfccfd2),
                        Color(0xFFfdbec6),
                        Color(0xFFdc8c97),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 140.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Full Name',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            InputTextField(
                              controller: displayNameController,
                              keyboardType: TextInputType.name,
                              hintText: 'Enter your full name',
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Email address',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            InputTextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Enter your Email address',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Password',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            InputTextField(
                              visibility: true,
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              hintText: 'Enter your Password',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                                      genders.forEach((gender) =>
                                          gender.isSelected = false);
                                      genders[index].isSelected = true;
                                    });
                                  },
                                  child: CustomRadio(genders[index]),
                                );
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: Button(
                            text: 'Create Account',
                            textColor: Colors.white,
                            color: Color(0xFFdc8c97),
                            fontSize: 18,
                            onPressed: () async {
                              toggleSpinner();
                              if (displayNameController.text.length < 6) {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message: "A valid full name is required.",
                                  ),
                                );
                              } else {
                                try {
                                  await signUpWithEmailPassword({
                                    'displayName':
                                        displayNameController.text.trim(),
                                    'email': emailController.text.trim(),
                                    'password': passwordController.text.trim(),
                                    'gender': selectedGender(),
                                    'cover':"https://firebasestorage.googleapis.com/v0/b/whichone-7de3e.appspot.com/o/coverImages%2Fimage_picker451391046.jpg?alt=media&token=59f07a6e-28c8-42d2-8a8e-c05111ca41a8",
                                    'profil':"https://firebasestorage.googleapis.com/v0/b/whichone-7de3e.appspot.com/o/coverImages%2Fimage_picker451391046.jpg?alt=media&token=59f07a6e-28c8-42d2-8a8e-c05111ca41a8"
                                  });
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/Login',
                                  );
                                } catch (error) {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message: error.toString(),
                                    ),
                                  );
                                }
                              }
                              toggleSpinner();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageProfil extends StatelessWidget {
  const ImageProfil({
    Key? key,
    this.onPressed,
    required File? profilImage,
  })  : _profilImage = profilImage,
        super(key: key);

  final File? _profilImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
        child: Stack(
          children: [
            if (_profilImage == null)
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                    color: Color(0xFFdc8c97),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 80,
                backgroundImage: _profilImage == null
                    ? MemoryImage(kTransparentImage)
                    : FileImage(_profilImage!) as ImageProvider,
              ),
            ),
            if (_profilImage == null)
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 50,
                  color: Color(0xFFffd6da),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

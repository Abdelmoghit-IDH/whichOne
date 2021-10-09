import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:azedpolls/components/button.dart';
import 'package:azedpolls/components/circular_indicator.dart';
import 'package:azedpolls/components/custom_appbar.dart';
import 'package:azedpolls/components/input_text.dart';
import 'package:azedpolls/notifiers/auth_notifier.dart';
import 'package:azedpolls/services/auth_services.dart';
import '../../const.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;

  void toggleSpinner() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
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
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                        ),
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
                              'Full name',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            InputTextField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              hintText: 'Enter your full name',
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
                              keyboardType: TextInputType.text,
                              hintText: 'Enter your Password',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: Button(
                            text: 'Create Account',
                            textColor: Colors.white,
                            fontSize: 18,
                            onPressed: () async {
                              toggleSpinner();
                              if (nameController.text.length < 6) {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message: "A valid full name is required.",
                                  ),
                                );
                              } else {
                                try {
                                  await signUpWithEmailPassword(authNotifier, {
                                    'displayName': nameController.text,
                                    'email': emailController.text.trim(),
                                    'password': passwordController.text,
                                  });
                                  Navigator.pushReplacementNamed(
                                      context, '/Login');
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

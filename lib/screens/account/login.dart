import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:whichone/components/alert_dialog.dart';
import 'package:whichone/components/button.dart';
import 'package:whichone/components/circular_indicator.dart';
import 'package:whichone/components/input_text.dart';
import 'package:whichone/notifiers/auth_notifier.dart';
import 'package:whichone/services/auth_services.dart';
import '../../const.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = false;
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
      child: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => Alert(
              title: 'Exit App',
            ),
          );
        },
        child: Scaffold(
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
                        vertical: 100.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/whichOne_logo.png',
                            width: 200,
                            height: 200,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              InputTextField(
                                controller: emailController,
                                keyboardType: TextInputType.text,
                                hintText: 'Enter your Email',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
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
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Enter your Password',
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, '/ForgotPassword'),
                              child: Text(
                                'Forgot Password?',
                                style: kLabelStyle,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25.0),
                            width: double.infinity,
                            child: Button(
                              text: 'Login',
                              onPressed: () async {
                                toggleSpinner();
                                try {
                                  await signInWithEmailPassword(
                                    authNotifier,
                                    {
                                      'email': emailController.text.trim(),
                                      'password': passwordController.text,
                                    },
                                  );
                                  Navigator.pushReplacementNamed(
                                      context, '/Home');
                                } catch (error) {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message: error.toString(),
                                    ),
                                  );
                                }
                                toggleSpinner();
                              },
                              fontSize: 18,
                              textColor: Colors.white,
                              color: Color(0xffdc8c97),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/SignUp'),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don\'t have an Account? ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}

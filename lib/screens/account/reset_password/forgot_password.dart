import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:whichone/components/button.dart';
import 'package:whichone/components/circular_indicator.dart';
import 'package:whichone/components/custom_appbar.dart';
import 'package:whichone/global/strings.dart';
import '../../../const.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: '',
        onPressLeading: () => Navigator.pop(context),
        onPressTrailing: () {},
      ),
      body: Stack(
        children: [
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
          BodyForgotPassword(),
        ],
      ),
    );
  }
}

class BodyForgotPassword extends StatefulWidget {
  BodyForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  _BodyForgotPasswordState createState() => _BodyForgotPasswordState();
}

class _BodyForgotPasswordState extends State<BodyForgotPassword> {
  final emailController = TextEditingController();
  bool _isLoading = false;

  toggleSpinner() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: CircularIndicator(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Reset password',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      resetPassword,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Email address',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your Password',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    width: double.infinity,
                    child: Button(
                      textColor: Colors.white,
                      text: 'Send Instructions',
                      fontSize: 17,
                      onPressed: () {
                        Navigator.pushNamed(context, "/CheckEmail");
                        /* toggleSpinner();
                        try {
                          await ForgotPassword(emailController.text.trim());
                          Navigator.pushNamed(context, "/CheckEmail");
                        } catch (error) {
                          showMessage(context, error);
                        }
                        toggleSpinner(); */ //TODO: yodagile project
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

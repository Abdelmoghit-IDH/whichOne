import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whichone/components/alert_dialog.dart';
import 'package:whichone/components/button.dart';
import '../../const.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                        ),
                        Text(
                          'Sign In',
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
                              'Email',
                              style: kLabelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: kBoxDecorationStyle,
                              height: 60.0,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Email',
                                  hintStyle: kHintTextStyle,
                                ),
                              ),
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
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/ForgotPassword'),
                            child: Text(
                              'Forgot Password?',
                              style: kLabelStyle,
                            ),
                          ),
                        ),
                        Container(
                          height: 20.0,
                          child: Row(
                            children: <Widget>[
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Checkbox(
                                  value: _rememberMe,
                                  checkColor: Color(0xffdc8c97),
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                'Remember me',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: Button(
                            text: 'Login',
                            onPressed: () =>
                                Navigator.pushNamed(context, '/Home'),
                            fontSize: 18,
                            textColor: Colors.white,
                            color: Color(0xffdc8c97),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/SignUp'),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:whichone/screens/account/login.dart';
import 'package:whichone/screens/home/home.dart';
import 'animations/animation_route.dart';
import 'screens/account/reset_password/check_mail.dart';
import 'screens/account/reset_password/forgot_password.dart';
import 'screens/account/sign_up.dart';
import 'screens/init_app/splash.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return AnimationRoute.fadeThrough(settings, (context) {
      switch (settings.name) {
        case '/Splash':
          return Splash();
        case '/Login':
          return Login();
        case '/Home':
          return Home();
        case '/ForgotPassword':
          return ForgotPassword();
        case '/CheckEmail':
          return CheckEmail();
        case '/SignUp':
          return SignUp();
        default:
          return SizedBox.shrink();
      }
    });
  }
}

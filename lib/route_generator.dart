import 'package:flutter/material.dart';
import 'package:whichone/screens/account/login.dart';
import 'package:whichone/screens/home/home.dart';
import 'animations/animation_route.dart';
import 'screens/init_app/splash.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return AnimationRoute.fadeThrough(settings, (context) {
      switch (settings.name) {
        case '/Splash':
          return Splash();
        case '/Login':
          return LoginScreen();
        case '/Home':
          return Home();
        default:
          return SizedBox.shrink();
      }
    });
  }
}
import 'package:flutter/material.dart';
import 'animations/animation_route.dart';
import 'screens/splash.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return AnimationRoute.fadeThrough(settings, (context) {
      switch (settings.name) {
        case '/Splash':
          return Splash();
        default:
          return SizedBox.shrink();
      }
    });
  }
}
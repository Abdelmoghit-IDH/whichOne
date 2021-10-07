import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whichone/animations/fade_route.dart';
import 'package:whichone/screens/account/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        FadeRoute(
          page: LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("splash"),
      ),
    );
  }
}

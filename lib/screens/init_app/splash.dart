import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azedpolls/notifiers/auth_notifier.dart';
import 'package:azedpolls/services/auth_services.dart';

bool _isLogged = false;
String _username = "Name";

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    initializeApp(context).whenComplete(() => startApp());
    super.initState();
  }

  Future initializeApp(context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      _isLogged = true;
    } else {
      _isLogged = false;
    }
  }

  startApp() async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    authNotifier.username = _username;
    if (_isLogged) {
      initializeCurrentUser(authNotifier);
      Navigator.pushReplacementNamed(context, '/Home');
    } else {
      Navigator.pushReplacementNamed(context, '/Login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 220,
                height: 220,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

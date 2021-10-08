import 'package:flutter/cupertino.dart';
import 'package:whichone/models/user_model.dart';

class AuthNotifier with ChangeNotifier {
  UserModel? _user;
  String? _username;

  UserModel get user => _user!;
  String get username => _username!;

  set user(UserModel currentUser) {
    _user = currentUser;
    notifyListeners();
  }

  set username(String username) {
    _username = username;
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? photoURL;
  int? coins;
  String? role;

  UserModel(String uid, Map<String, dynamic> data) {
    this.uid = uid;
    this.displayName = data['displayName'];
    this.email = data['email'] ?? "";
    this.photoURL = data['photoURL'] ?? "";
    this.coins = data['coins'] ?? 0;
    this.role = data['role'] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': this.displayName,
      'email': this.email,
      'photoURL': this.photoURL,
      'coins': this.coins,
      'role': this.role,
    };
  }

  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(this.uid)
        .set(this.toMap());
  }
}
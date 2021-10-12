import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? photoURL;

  UserModel(String uid, Map<String, dynamic> data) {
    this.uid = uid;
    this.displayName = data['displayName'];
    this.email = data['email'] ?? "";
    this.photoURL = data['photoURL'] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': this.displayName,
      'email': this.email,
      'photoURL': this.photoURL,
    };
  }

  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(this.uid)
        .set(this.toMap());
  }
}
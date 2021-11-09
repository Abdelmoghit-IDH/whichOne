import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? fullName;
  String? username;
  String? email;
  String? gender;
  String? imageUrl;
  String? coverUrl;
  int? follower;
  int? following;

  UserModel(String uid, Map<String, dynamic> data) {
    this.uid = uid;
    this.fullName = data['fullName'];
    this.username = data['username'] ?? "";
    this.email = data['email'] ?? "";
    this.gender = data['gender'] ?? "";
    this.imageUrl = data['profil'] ?? "";
    this.coverUrl = data['cover'] ?? "";
    this.follower = data['follower'] as int? ?? 0;
    this.following = data['follower'] as int? ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': this.fullName,
      'email': this.email,
      'username': this.username,
      'gender': this.gender,
      'cover': this.coverUrl,
      'profil': this.imageUrl,
    };
  }

  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(this.uid)
        .update(this.toMap());
  }
}

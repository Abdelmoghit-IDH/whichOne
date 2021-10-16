import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? fullname;
  String? username;
  String? email;
  String? gender;
  String? imageUrl;
  String? coverUrl;
  int? follower;
  int? following;

  UserModel(String uid, Map<String, dynamic> data) {
    this.uid = uid;
    this.fullname = data['fullname'];
    this.username = data['username'] ?? "";
    this.email = data['email'] ?? "";
    this.gender = data['gender'] ?? "";
    this.imageUrl = data['imageUrl'] ?? "";
    this.coverUrl = data['coverUrl'] ?? "";
    this.follower = data['follower'] as int? ?? 0;
    this.following = data['follower'] as int? ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'fullname': this.fullname,
      'username': this.username,
      'email': this.email,
      'gender': this.gender,
      'imageUrl': this.imageUrl,
      'coverUrl': this.coverUrl,
    };
  }

  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(this.uid)
        .set(this.toMap());
  }
}

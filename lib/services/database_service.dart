import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  getUserByUsername(String name) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where("name", isGreaterThanOrEqualTo: name)
        .get();
  }

  getUserByUserEmail(String email) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get();
  }

  //collection reference
  final CollectionReference azedpollsCollection =
      FirebaseFirestore.instance.collection('users');
  final followersReference = FirebaseFirestore.instance.collection('followers');
  final followingReference =
      FirebaseFirestore.instance.collection('followings');

  Future uploadUserData(
      String email, String fullName, String nickname, String gender) async {
    followersReference.doc(uid).collection('userFollowing');
    followingReference.doc(uid).collection('userFollowers');
    return await azedpollsCollection.doc(uid).set({
      "email": email,
      "fullName": fullName,
      "gender": gender,
      'uid': uid,
    });
  }
}

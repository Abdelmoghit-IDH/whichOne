import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:azedpolls/models/user_model.dart';
import 'package:azedpolls/notifiers/auth_notifier.dart';

import 'database_service.dart';

Future<void> initializeCurrentUser(AuthNotifier authNotifier) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = new UserModel(
        user.uid,
        doc.data()!,
      );

      authNotifier.user = userModel;
    }
  } catch (error) {
    throw error.toString();
  }
}

Future<void> logout(AuthNotifier authNotifier) async {
  return await FirebaseAuth.instance.signOut();
}

String handleAuthExceptions(FirebaseAuthException error) {
  String message = "";
  switch (error.code) {
    case "email-already-in-use":
      message = "An account is already exists with the given email address.";
      break;
    case "invalid-email":
      message = "The email is invalid.";
      break;
    case "unknown":
      message = "Make sure to fill all requirements.";
      break;
    case "weak-password":
      message = "The password is not strong enough.";
      break;
    case "user-disabled":
      message = "Sorry, your account is disabled.";
      break;
    case "user-not-found":
      message = "There is no user corresponding to the given email.";
      break;
    case "wrong-password":
      message = "The given password is uncorrect.";
      break;
    case "auth/user-not-found":
      message = "There is no user corresponding to the given email.";
      break;
    default:
      message = "Something is wrong, try later.";
  }
  return message;
}

Future<void> signUpWithEmailPassword(Map<String, dynamic> user) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.createUserWithEmailAndPassword(
      email: user['email'],
      password: user['password'],
    );

    print(_auth.currentUser!.uid);

    await DatabaseService(uid: _auth.currentUser!.uid).uploadUserData(
      user['email'],
      user['displayName'],
      user['email'],
      user['gender'],
      user['cover'],
      user['profil'],
    );

    await _auth.currentUser!.updateDisplayName(user['displayName']);
    await _auth.currentUser!.sendEmailVerification();

    await FirebaseAuth.instance.signOut();
  } on FirebaseAuthException catch (error) {
    throw handleAuthExceptions(error);
  }
}

Future<void> resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (error) {
    throw handleAuthExceptions(error);
  }
}

Future<void> signInWithEmailPassword(
    AuthNotifier authNotifier, Map<String, dynamic> user) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signInWithEmailAndPassword(
      email: user['email'],
      password: user['password'],
    );
    if (_auth.currentUser!.emailVerified) {
      await initializeCurrentUser(authNotifier);
    } else {
      await _auth.signOut();
      throw "Check your mail for the email verification.";
    }
  } on FirebaseAuthException catch (error) {
    throw handleAuthExceptions(error);
  }
}

String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

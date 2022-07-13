import 'package:consolelovers/Model/Gamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:consolelovers/Services/AuthBase.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService extends AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Gamer?> currentUser() async {
    try {
      User? _user = _firebaseAuth.currentUser;
      return _gamerFromFirebase(_user);
    } catch (e) {
      return null;
    }
  }

  Gamer? _gamerFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return Gamer(
        gamerID: user.uid,
        gamerEmail: user.email!,
      );
    }
  }

  @override
  Future<Gamer?> createEmailPassword(String email, String sifre) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: sifre);
      return _gamerFromFirebase(result.user);
    } catch (e) {
      debugPrint('FirebaseAuthta kullanıcı oluşturma  hatası ${e.toString()}');
      return null;
    }
  }

  @override
  Future<Gamer?> signInEmailPassword(String email, String sifre) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: sifre);
      return _gamerFromFirebase(result.user);
    } catch (e) {
      debugPrint('FirebaseAuthta oturum açma hatası ${e.toString()}');
      return null;
    }
  }

  Future<bool?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("Singout Hatası: ${e.toString()}");
      return null;
    }
  }
}

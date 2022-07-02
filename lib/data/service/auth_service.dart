import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/alerts.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  //giriş yap fonksiyonu
  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushNamedAndRemoveUntil(
          context, "/piyasalar", (route) => false);
    } on FirebaseAuthException {
      getErrorAlert(context, "Hatalı Giriş Yaptınız!");
    }
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<User?> createPerson(String name, String email, String password,
      List exchangeList, List alarms, BuildContext context) async {
    String? token = await _messaging.getToken();
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Navigator.pushReplacementNamed(context, "/login");
      await _firestore.collection("Person").doc(user.user!.uid).set({
        'userName': name,
        'email': email,
        'exchangeList': exchangeList,
        'alarms': alarms,
        'fcm': token,
      });
    } on FirebaseAuthException {
      getErrorAlert(context, "Hatalı Giriş Yaptınız!");
    }
  }
}

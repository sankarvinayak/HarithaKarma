import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';
import 'package:harithakarma/service/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future SignIn(@required String email, @required String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      return DatabaseService().getutype(user!.uid);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future sendPasswordResetEmail(String email) async {
    print("Inreset function");
    var reset_result = null;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Email send");
    } catch (e) {
      print(e);
    }
  }

  getType(UserCredential result) async {
    List itemList = [];
    try {
      await FirebaseFirestore.instance
          .collection('Utype')
          .where('uid', isEqualTo: result.user!.uid)
          .get();

      return itemList;
    } catch (e) {}
  }

  Future signUpEmail(
    String email,
    String password,
    String name,
    String userRole,
  ) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await DatabaseService()
          .SetUserData(authResult.user!.uid, name, userRole, email);
      return authResult.user!.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

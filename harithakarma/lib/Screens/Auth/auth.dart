import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:harithakarma/models/user.dart';
import 'package:harithakarma/service/firestore_service.dart';

import '../../locator.dart';

class AuthService {
  AppUser? _userFromFirebaseUser(User? user) {
    //return user != null ? AppUser(user.uid) : null;
  }

  // late FirestoreService _firestoreService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future SignIn(@required String email, @required String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
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
      // if (authResult != null) {
      //   await _firestoreService
      //       .createUser(AppUser(authResult.user!.uid, name, email, userRole));
      // }
      AppUser user = AppUser(authResult.user!.uid, name, email, userRole);
      FirebaseFirestore.instance.collection("Utype").add(user.toMap());
      return authResult.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

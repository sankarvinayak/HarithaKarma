import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:harithakarma/database.dart';
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
      //  var collection= FirebaseFirestore.instance
      //       .collection("Utype")
      //       .where("uid", isEqualTo: result.user!.uid);
      //       var docsnapshot=await collection.
      User? user = result.user;
      return DatabaseService().getutype(user!.uid);
    } catch (error) {
      print(error.toString());
      return null;
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
// Future getData(String username) async {
//     List dataList = [];
//     try {
//       await FirebaseFirestore.instance.collection('userdata').where('user', isEqualTo: username).get().then((QuerySnapshot querySnapshot) => {
//             querySnapshot.docs.forEach((doc) {
//               itemList.add(doc.data());
//             }),
//           });
//       return itemList;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

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

      // AppUser user = AppUser(authResult.user!.uid, name, email, userRole);
      // FirebaseFirestore.instance.collection("Utype").add(user.toMap());
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

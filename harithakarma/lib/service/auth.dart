import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harithakarma/service/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      return DatabaseService().getutype(user!.uid);
    } on FirebaseException catch (e) {
      throw (e.message.toString());
    }
  }

  Future sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
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
    } catch (e) {
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

      await DatabaseService()
          .setUserData(authResult.user!.uid, name, userRole, email);
      return authResult.user!.uid;
    } on FirebaseException catch (e) {
      throw (e.message.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      return null;
    }
  }
}

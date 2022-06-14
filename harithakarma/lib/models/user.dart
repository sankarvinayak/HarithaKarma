import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String uid;
  String name;
  String email;
  String userRole;
  AppUser(this.uid, this.name, this.email, this.userRole);
// factory AppUser.fromDocumentSnapshot({required DocumentSnapshot<Map<String,dynamic>> doc}){
//     return AppUser(
//         title: doc.data()!["title"],
//         content:doc.data()!["content"],
//     );
// }
//   AppUser.fromData(Map<String, dynamic> data)
//       : uid = data['id'],
//         name = data['name'],
//         email = data['email'],
//         userRole = data['userRole'];
//   Map<String, dynamic> toJson() {
//     return {'uid': uid, 'name': name, 'email': email, 'userRole': userRole};
//   }
//
  Map<String, dynamic> toMap() {
    return {"uid": uid, "name": name, "email": email, "userRole": userRole};
  }
}

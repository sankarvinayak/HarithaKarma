// import 'package:cloud_firestore/cloud_firestore.dart';

// class AppUser {
//   String uid;
//   String name;
//   String email;
//   String userRole;
//   AppUser(this.uid, this.name, this.email, this.userRole);
// // factory AppUser.fromDocumentSnapshot({required DocumentSnapshot<Map<String,dynamic>> doc}){
// //     return AppUser(
// //         title: doc.data()!["title"],
// //         content:doc.data()!["content"],
// //     );
// // }
// //   AppUser.fromData(Map<String, dynamic> data)
// //       : uid = data['id'],
// //         name = data['name'],
// //         email = data['email'],
// //         userRole = data['userRole'];
// //   Map<String, dynamic> toJson() {
// //     return {'uid': uid, 'name': name, 'email': email, 'userRole': userRole};
// //   }
// //
//   Map<String, dynamic> toMap() {
//     return {"uid": uid, "name": name, "email": email, "userRole": userRole};
//   }

//   factory AppUser.fromDocumentSnapshot(
//       {required DocumentSnapshot<Map<String, dynamic>> doc}) {
//     return AppUser(
//       "",
//       "",
//       "",
//       doc.data()!["content"],
//     );
//   }
// }
class appUser {
  String? utype;
  String? uid;
  String? name;
  String? email;
  String? panchayath;
  String? phone;
  appUser.c();
  appUser(
      this.utype, this.uid, this.email, this.name, this.panchayath, this.phone);
}

class employee extends appUser {
  String? empid;

  employee(super.utype, super.uid, super.email, super.name, super.panchayath,
      super.phone, this.empid);
  employee.c() : super.c();
}

class homeUser extends appUser {
  int? ward_no;
  int? house_no;
  String? house;
  String? owner;

  homeUser(super.utype, super.uid, super.email, super.name, super.panchayath,
      super.phone, this.house, this.house_no, this.owner, this.ward_no);
  homeUser.c() : super.c();
}

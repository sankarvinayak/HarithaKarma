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
import 'package:shared_preferences/shared_preferences.dart';

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

employee? globadmin;
setadmin(uid, name, email, panchayath, phone, empid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('empid', empid);
  //globadmin?.empid = empid;
  await prefs.setString('utype', 'Admin');
  //globadmin?.utype = 'Admin';
  await prefs.setString('name', name);
  //globadmin?.name = name;
  await prefs.setString('email', email);
  //globadmin?.email = email;
  await prefs.setString('panchayath', panchayath);
  //globadmin?.panchayath = panchayath;
  await prefs.setString('phone', phone);
  //globadmin?.phone = phone;
  await prefs.setString('uid', uid);
  //globadmin?.uid = uid;
  globadmin = employee('Admin', uid, email, name, panchayath, phone, empid);
}

initadmin() async {
  final prefs = await SharedPreferences.getInstance();

  final String? empid = prefs.getString('empid');
  final String utype = 'Admin';

  final String? name = prefs.getString('name');

  final String? email = prefs.getString('email');

  final String? panchayath = prefs.getString('panchayath');

  final String? phone = prefs.getString('phone');

  final String? uid = prefs.getString('uid');
  ;
  globadmin = employee(utype, uid, email, name, panchayath, phone, empid);
}

homeUser? globhome;
sethome(
    uid, name, email, panchayath, phone, wardno, houseno, house, owner) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('uid', uid);
  //globhome?.uid = uid;
  //globhome?.utype = 'Home';
  await prefs.setString('utype', 'Home');
  //globhome?.name = name;
  await prefs.setString('name', name);
  //globhome?.email = email;
  await prefs.setString('email', email);
  //globhome?.panchayath = panchayath;
  await prefs.setString('panchayath', panchayath);
  await prefs.setString('phone', phone);
  //globhome?.phone = phone;
  await prefs.setInt('ward', wardno);
  //globhome?.ward_no = wardno;
  await prefs.setInt('house_no', houseno);
  //globhome?.house_no = houseno;
  await prefs.setString('house', house);
  //globhome?.house = house;
  await prefs.setString('owner', owner);
  //globhome?.owner = owner;
  globhome = homeUser('Home', uid, email, name, panchayath, phone, house,
      houseno, owner, wardno);
}

inithome() async {
  final prefs = await SharedPreferences.getInstance();

  final String? uid = prefs.getString('uid');
  final String utype = 'Home';

  final String? name = prefs.getString('name');

  final String? email = prefs.getString('email');

  final String? panchayath = prefs.getString('panchayath');

  final String? phone = prefs.getString('phone');

  final String? ward = prefs.getString('ward');

  final String? house_no = prefs.getString('house_no');

  final String? house = prefs.getString('house');

  final String? owner = prefs.getString('owner');
  globhome = homeUser(
      utype, uid, email, name, panchayath, phone, house, house_no, owner, ward);
  print(globhome!.name);
}

employee? globfield;
setfield(
  uid,
  name,
  email,
  panchayath,
  phone,
  empid,
) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('empid', empid);
  //globfield?.empid = empid;
  await prefs.setString('utype', 'Field');
  //globfield?.utype = 'Field';
  await prefs.setString('name', name);
  //globfield?.name = name;
  await prefs.setString('email', email);
  //globfield?.email = email;
  await prefs.setString('panchayath', panchayath);
  //globfield?.panchayath = panchayath;
  await prefs.setString('phone', phone);
  //globfield?.phone = phone;
  await prefs.setString('uid', uid);
  //globfield?.uid = uid;
  globfield = employee('Field', uid, email, name, panchayath, phone, empid);
}

initfield() async {
  final prefs = await SharedPreferences.getInstance();

  final String? empid = prefs.getString('empid');
  final String? utype = 'Field';

  final String? name = prefs.getString('name');

  final String? email = prefs.getString('email');

  final String? panchayath = prefs.getString('panchayath');

  final String? phone = prefs.getString('phone');

  final String? uid = prefs.getString('uid');
  ;
  globfield = employee(utype, uid, email, name, panchayath, phone, empid);
}

cleardata() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('uid');
  await prefs.remove('utype');
  await prefs.remove('name');
  globadmin = new employee.c();
  globfield = new employee.c();
  globhome = new homeUser.c();
}

class homeUser extends appUser {
  String? ward_no;
  String? house_no;
  String? house;
  String? owner;

  homeUser(super.utype, super.uid, super.email, super.name, super.panchayath,
      super.phone, this.house, this.house_no, this.owner, this.ward_no);
  homeUser.c() : super.c();
}

unique(values) {
  var set = values.toSet();
  return set.toList();
}

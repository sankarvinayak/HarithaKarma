import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  //String? uid;
  String? utype;
  var panchayath;

  final CollectionReference utypeCollection =
      FirebaseFirestore.instance.collection('Utype');
  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('Admin');
  final CollectionReference fieldCollection =
      FirebaseFirestore.instance.collection('Field');
  final CollectionReference homeCollection =
      FirebaseFirestore.instance.collection('Home');

  Future<void> SetUserData(
      String uid, String name, String userRole, String email) async {
    return await utypeCollection
        .doc(uid)
        .set({'uid': uid, 'name': name, 'userRole': userRole, 'email': email});
  }

  Future<void> addAdmin(String name, String email, String uid, String empid,
      String Panchayath, String phone) async {
    return await adminCollection.doc(uid).set({
      'name': name,
      'email': email,
      'empid': empid,
      'panchayath': Panchayath,
      'phone': phone
    });
  }

  // Future<void> updateAdmin(String name, String email, String uid, String empid,
  //     String Panchayath, String phone) async {
  //   return await adminCollection.doc(uid).update({
  //     'name': name,
  //     'email': email,
  //     'empid': empid,
  //     'panchayath': Panchayath,
  //     'phone': phone
  //   });
  // }

  Future<void> addHome(
      String name,
      String email,
      String uid,
      String Panchayath,
      String ward,
      String houseno,
      String owner,
      String house,
      String phone) async {
    return await homeCollection.doc(uid).set({
      'name': name,
      'panchayath': Panchayath,
      'ward': ward,
      'house_no': houseno,
      'owner': owner,
      'house': house,
      'phone': phone
      // 'timestamp': DateTime.now()
    });
  }

  getHomeReference() {
    return homeCollection;
  }

  getFieldReference() {
    return fieldCollection;
  }

  // Future<void> updateHome(
  //     String name,
  //     String email,
  //     String uid,
  //     String Panchayath,
  //     int ward,
  //     int houseno,
  //     String owner,
  //     String house,
  //     String phone) async {
  //   return await homeCollection.doc(uid).update({
  //     'name': name,
  //     'panchayath': Panchayath,
  //     'ward': ward,
  //     'house_no': houseno,
  //     'owner': owner,
  //     'house': house,
  //     'phone': phone
  //     // 'timestamp': DateTime.now()
  //   });
  // }

  Future<void> addField(String name, String email, String uid, String empid,
      String Panchayath, String phone) async {
    return await fieldCollection.doc(uid).set({
      'name': name,
      'email': email,
      'empid': empid,
      'panchayath': Panchayath,
      'phone': phone
    });
  }

  // getPanchayath() async {
  //   await adminCollection.doc().get().then((DocumentSnapshot snapshot) {
  //     panchayath = snapshot.data();
  //   });
  //   return panchayath;
  // }

  getutype(uid) async {
    // await utypeCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
    //   var dic = snapshot.data() as Map<String, dynamic>;
    //   this.utype = dic['userRole'].toString();
    // });
    //     var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await utypeCollection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      this.utype =
          data?['userRole'].toString(); // <-- The value you want to retrieve.
      // Call setState if needed.
    }
    print(utype);
    return utype;
  }

  getpanchayath() {
    return adminCollection.orderBy('panchayath').snapshots();
  }

  gethomename(uid, utype) async {
    var docSnapshot = await homeCollection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      this.utype = data?['userRole'].toString();
    }
  }

  getDetails(String uid, String utype) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('utype', utype);
    if (utype == "Admin") {
      employee admin = employee.c();
      admin.uid = uid;
      admin.utype = utype;
      var docSnapshot = await adminCollection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        admin.email = data?['email'].toString();
        admin.empid = data?['empid'].toString();
        admin.name = data?['name'].toString();
        admin.panchayath = data?['panchayath'].toString();
        admin.phone = data?['phone'].toString();
        setadmin(uid, admin.name, admin.email, admin.panchayath, admin.phone,
            admin.empid);
        // <-- The value you want to retrieve.
        // Call setState if needed.
      }
      return admin;
    } else if (utype == "Home") {
      homeUser home = homeUser.c();
      home.uid = uid;
      home.utype = utype;
      var docSnapshot = await homeCollection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        home.phone = data?['phone'].toString();
        home.email = data?['email'].toString();
        home.panchayath = data?['panchayath'].toString();
        home.house_no = data?['house_no'];
        home.ward_no = data?['ward'];
        home.house = data?['house'].toString();
        home.name = data?['name'].toString();
        home.owner = data?['owner'].toString();
      }
      sethome(uid, home.name, home.email, home.panchayath, home.phone,
          home.ward_no, home.house_no, home.house, home.owner);
    } else {
      employee employ = employee.c();
      employ.uid = uid;
      employ.utype = utype;
      var docSnapshot = await fieldCollection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        employ.email = data?['email'].toString();
        employ.empid = data?['empid'].toString();
        employ.name = data?['name'].toString();
        employ.panchayath = data?['panchayath'].toString();
        employ.phone = data?['phone'].toString();
      }
      setfield(uid, employ.name, employ.email, employ.panchayath, employ.phone,
          employ.empid);
    }
  }

  setuserAdmin(Panchayath) async {
    QuerySnapshot querySnapshot =
        await adminCollection.where('panchayath', isEqualTo: Panchayath).get();
    var doc = querySnapshot.docs[0];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('Adminemail', doc['email']);
    prefs.setString('Adminname', doc['name']);
    prefs.setString('Adminphone', doc['phone']);
    //print(doc['name']);
    return "hi";
  }
}

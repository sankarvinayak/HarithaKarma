import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harithakarma/Shared/format_timestamp.dart';
import 'package:harithakarma/models/user.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//A class theough which all calls to the Firebase Firestore database is made
class DatabaseService {
  String? utype;
  String? panchayath;
  final CollectionReference collectionRequest =
      FirebaseFirestore.instance.collection('collection_request');
  final CollectionReference collectionHistory =
      FirebaseFirestore.instance.collection('collection_history');
  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('complaints');
  final CollectionReference report =
      FirebaseFirestore.instance.collection('report');
  final CollectionReference visitHistory =
      FirebaseFirestore.instance.collection('visit_history');
  final CollectionReference utypeCollection =
      FirebaseFirestore.instance.collection('Utype');
  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('Admin');
  final CollectionReference fieldCollection =
      FirebaseFirestore.instance.collection('Field');
  final CollectionReference homeCollection =
      FirebaseFirestore.instance.collection('Home');

//Add user data to the database
  Future<void> setUserData(
      String uid, String name, String userRole, String email) async {
    return await utypeCollection
        .doc(uid)
        .set({'uid': uid, 'name': name, 'userRole': userRole, 'email': email});
  }

  Future<void> addCollectionRequest() async {
    var docId = await checkRequest(globhome!.wardNo, globhome!.panchayath);
    List uid = globhome!.uid!.split(' ');
    List<dynamic> uidD = List<dynamic>.from(uid);
    return await collectionRequest.doc(docId).set({
      'panchayath': globhome!.panchayath,
      'ward': globhome!.wardNo,
      'uid': FieldValue.arrayUnion(uidD),
      'status': "pending"
    }, SetOptions(merge: true));
  }

  checkRequest(String? ward, String? panchayath) async {
    var querySnapshot = await collectionRequest
        .where('panchayath', isEqualTo: panchayath)
        .where('ward', isEqualTo: ward)
        .where('status', isEqualTo: 'pending')
        .get();
    try {
      return querySnapshot.docs[0].reference.id;
    } catch (e) {
      return null;
    }
  }

  checkRequested() async {
    var querySnapshot = await collectionRequest
        .where('panchayath', isEqualTo: globhome!.panchayath)
        .where('ward', isEqualTo: globhome!.wardNo)
        .where('status', isEqualTo: 'pending')
        .get();
    try {
      List<dynamic> users = querySnapshot.docs[0]['uid'];
      return users.contains(globhome!.uid);
    } catch (e) {
      return false;
    }
  }

  getWardRequestCount(String ward) async {
    var querySnapshot = await collectionRequest
        .where('panchayath', isEqualTo: globfield!.panchayath)
        .where('ward', isEqualTo: ward)
        .where('status', isEqualTo: "pending")
        .get();
    try {
      List<dynamic> users = querySnapshot.docs[0]['uid'];
      return users.length.toString();
    } catch (e) {
      return 0.toString();
    }
  }

  getLastvisited(String ward) async {
    var querySnapshot = await visitHistory
        .where('panchayath', isEqualTo: globfield!.panchayath)
        .where('ward', isEqualTo: ward)
        .orderBy('date', descending: true)
        .get();
    try {
      String date = querySnapshot.docs[0]['date'];
      return date;
    } catch (e) {
      return "";
    }
  }

//Add admin data to the database
  Future<void> addAdmin(String name, String email, String uid, String empid,
      String panchayath, String phone) async {
    return await adminCollection.doc(uid).set({
      'name': name,
      'email': email,
      'empid': empid,
      'panchayath': panchayath,
      'phone': phone
    });
  }

//add data to collection history
  Future<void> addCollectionHistory(
      String uid,
      String name,
      String? collectorId,
      String ward,
      String panchayath,
      String houseName,
      String houseNo) async {
    return await collectionHistory.doc().set({
      'uid': uid,
      'name': name,
      'collector': collectorId,
      'collector_name': globfield!.name,
      'ward': ward,
      'panchayath': panchayath,
      'house_no': houseNo,
      'house': houseName,
      'status': "arriving today"
    });
  }

//set ward for a field user
  Future<void> setWard(String uid, List wards) async {
    return await fieldCollection
        .doc(uid)
        .set({'ward': wards}, SetOptions(merge: true));
  }

//update collection status
  Future<void> updateCollectionStatus(String docId) async {
    return await collectionHistory.doc(docId).set(
        {'status': "collected", "datetime": DateTime.now()},
        SetOptions(merge: true));
  }

//update complaint status
  Future<void> updateComplaintStatus(String docId) async {
    return await complaints.doc(docId).set({
      'status': "closed",
    }, SetOptions(merge: true));
  }

  Future<void> updateReportStatus(String docId) async {
    return await report.doc(docId).set({
      'status': "closed",
    }, SetOptions(merge: true));
  }

//create a new complaint
  Future<void> addComplaint(String title, String desc, String? ward) async {
    return await complaints.doc().set(
      {
        'title': title,
        "date": formatTimestamp(Timestamp.now()),
        'desc': desc,
        "ward": ward,
        "status": "pending",
        "panchayath": globhome!.panchayath,
      },
    );
  }

  Future<void> report_waste(
      String title, String desc, String? ward, String? location) async {
    return await report.doc().set(
      {
        'title': title,
        "date": formatTimestamp(Timestamp.now()),
        'desc': desc,
        "ward": ward,
        "location": location,
        "status": "pending",
        "panchayath": globhome!.panchayath,
      },
    );
  }

//add details of home user
  Future<void> addHome(
      String name,
      String email,
      String uid,
      String panchayath,
      String ward,
      String houseno,
      String owner,
      String house,
      String phone) async {
    return await homeCollection.doc(uid).set({
      'name': name,
      'panchayath': panchayath,
      'ward': ward,
      'house_no': houseno,
      'owner': owner,
      'house': house,
      'phone': phone
    });
  }

//get ward details of a field user
  getWardDetails(uid) async {
    List<dynamic>? ward = [];
    var docSnapshot = await fieldCollection.doc(uid).get();
    if (docSnapshot.exists) {
      try {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        ward = data?['ward'];
      } catch (e) {}
    }

    return ward;
  }

//select a ward for visit by field user add each home user to the list of home to collect
  gotoward(ward, panchayath) async {
    wardVisit(ward);
    updateRequestStatus(ward);
    var querySnapshot = await homeCollection
        .where('panchayath', isEqualTo: panchayath)
        .where('ward', isEqualTo: ward)
        .get();
    for (var user in querySnapshot.docs) {
      addCollectionHistory(user.reference.id, user['name'], globfield!.uid,
          ward, user['panchayath'], user['house'], user['house_no']);
    }
  }

//add details of field agent
  Future<void> addField(String name, String email, String uid, String empid,
      String panchayath, String phone) async {
    return await fieldCollection.doc(uid).set({
      'name': name,
      'email': email,
      'empid': empid,
      'panchayath': panchayath,
      'phone': phone
    });
  }

  Future<void> updateRequestStatus(String ward) async {
    var docid = await checkRequest(ward, globfield!.panchayath);
    if (docid != null) {
      return await collectionRequest.doc(docid).set({
        'status': "collected",
      }, SetOptions(merge: true));
    }
  }

//add details to ward visit history
  Future<void> wardVisit(String ward) async {
    return await visitHistory.doc().set({
      'Collector': globfield!.name,
      'ward': ward,
      'empid': globfield!.empid,
      'panchayath': globfield!.panchayath,
      'date': formatTimestamp(Timestamp.now())
    });
  }

//get user type on login
  getutype(uid) async {
    var docSnapshot = await utypeCollection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      utype = data?['userRole'].toString();
    }
    return utype;
  }

//list of available panchayaths
  getpanchayath() {
    return adminCollection.orderBy('panchayath').snapshots();
  }

//get details of user on login initialize and store user details offline
  getDetails(String uid, String utype) async {
    if (utype == "Admin") {
      Employee admin = Employee.c();
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
        await setadmin(uid, admin.name, admin.email, admin.panchayath,
            admin.phone, admin.empid);
      }
      return admin;
    } else if (utype == "Home") {
      HomeUser home = HomeUser.c();
      home.uid = uid;
      home.utype = utype;
      var docSnapshot = await homeCollection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        home.phone = data?['phone'].toString();
        home.email = data?['email'].toString();
        home.panchayath = data?['panchayath'].toString();
        home.houseNo = data?['house_no'];
        home.wardNo = data?['ward'];
        home.house = data?['house'].toString();
        home.name = data?['name'].toString();
        home.owner = data?['owner'].toString();
      }
      await sethome(uid, home.name, home.email, home.panchayath, home.phone,
          home.wardNo, home.houseNo, home.house, home.owner);
    } else {
      Employee employ = Employee.c();
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
      await setfield(uid, employ.name, employ.email, employ.panchayath,
          employ.phone, employ.empid);
    }
  }

  Future<int> countHome(panchayath) async {
    try {
      var querySnapshot =
          await homeCollection.where('panchayath', isEqualTo: panchayath).get();
      return querySnapshot.size;
    } catch (e) {
      return 0;
    }
  }

  Future<int> countField(panchayath) async {
    try {
      var querySnapshot = await fieldCollection
          .where('panchayath', isEqualTo: panchayath)
          .get();
      return querySnapshot.size;
    } catch (e) {
      return 0;
    }
  }

  deleteuser() async {
    try {
      AuthService().deleteUser();
      final prefs = await SharedPreferences.getInstance();
      final String? uid = prefs.getString('uid');
      final String? utype = prefs.getString('utype');
      utypeCollection.doc(uid).delete();
      if (utype == 'Admin') {
        adminCollection.doc(uid).delete();
      } else if (utype == 'Field') {
        fieldCollection.doc(uid).delete();
      } else if (utype == 'Home') {
        homeCollection.doc(uid).delete();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

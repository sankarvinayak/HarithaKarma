import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harithakarma/Shared/format_timestamp.dart';
import 'package:harithakarma/models/user.dart';

//A class theough which all calls to the Firebase Firestore database is made
class DatabaseService {
  String? utype;
  var panchayath;
  final CollectionReference collection_request =
      FirebaseFirestore.instance.collection('collection_request');
  final CollectionReference collection_historycollection =
      FirebaseFirestore.instance.collection('collection_history');
  final CollectionReference complaintscollection =
      FirebaseFirestore.instance.collection('complaints');
  final CollectionReference visit_history_collection =
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
  Future<void> SetUserData(
      String uid, String name, String userRole, String email) async {
    return await utypeCollection
        .doc(uid)
        .set({'uid': uid, 'name': name, 'userRole': userRole, 'email': email});
  }

  Future<void> add_collection_request() async {
    var doc_id = await check_request();
    List uid = globhome!.uid!.split(' ');
    List<dynamic> uid_d = List<dynamic>.from(uid);
    return await collection_request.doc(doc_id).set({
      'panchayath': globhome!.panchayath,
      'ward': globhome!.ward_no,
      'uid': FieldValue.arrayUnion(uid_d),
      'status': "pending"
    }, SetOptions(merge: true));
  }

  check_request() async {
    var querySnapshot = await collection_request
        .where('panchayath', isEqualTo: globhome!.panchayath)
        .where('ward', isEqualTo: globhome!.ward_no)
        .where('status', isEqualTo: 'pending')
        .get();
    try {
      return querySnapshot.docs[0].reference.id;
    } catch (e) {
      return null;
    }
  }

  check_requested() async {
    var querySnapshot = await collection_request
        .where('panchayath', isEqualTo: globhome!.panchayath)
        .where('ward', isEqualTo: globhome!.ward_no)
        .where('status', isEqualTo: 'pending')
        .get();
    try {
      List<dynamic> users = querySnapshot.docs[0]['uid'];
      return users.contains(globhome!.uid);
    } catch (e) {
      return false;
    }
  }

  get_ward_requet_count(String ward) async {
    var querySnapshot = await collection_request
        .where('panchayath', isEqualTo: globfield!.panchayath)
        .where('ward', isEqualTo: ward)
        .get();
    // print("Function call");
    try {
      List<dynamic> users = querySnapshot.docs[0]['uid'];
      // print(users.length);
      return users.length.toString();
    } catch (e) {
      //print(0);
      return 0.toString();
    }
  }

  get_lastvisited(String ward) async {
    var querySnapshot = await visit_history_collection
        .where('panchayath', isEqualTo: globfield!.panchayath)
        .where('ward', isEqualTo: ward)
        .orderBy('date', descending: true)
        .get();
    try {
      String date = querySnapshot.docs[0]['date'];
      print(date);
      return date;
    } catch (e) {
      print(e);
      return "";
    }
  }

//Add admin data to the database
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

//add data to collection history
  Future<void> add_collection_history(
      String uid,
      String name,
      String? collectorId,
      String ward,
      String Panchayath,
      String houseName,
      String houseNo) async {
    return await collection_historycollection.doc().set({
      'uid': uid,
      'name': name,
      'collector': collectorId,
      'collector_name': globfield!.name,
      'ward': ward,
      'panchayath': Panchayath,
      'house_no': houseNo,
      'house': houseName,
      'status': "arriving today"
    });
  }

//set ward for a field user
  Future<void> set_ward(String uid, List wards) async {
    return await fieldCollection
        .doc(uid)
        .set({'ward': wards}, SetOptions(merge: true));
  }

//update collection status
  Future<void> update_collection_status(String docId) async {
    return await collection_historycollection.doc(docId).set(
        {'status': "collected", "datetime": DateTime.now()},
        SetOptions(merge: true));
  }

//update complaint status
  Future<void> update_complaint_status(String docId) async {
    return await complaintscollection.doc(docId).set({
      'status': "closed",
    }, SetOptions(merge: true));
  }

//create a new complaint
  Future<void> add_complaint(String title, String desc, String? ward) async {
    return await complaintscollection.doc().set(
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

//add details of home user
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
    });
  }

//get ward details of a field user
  getWardDetails(uid) async {
    var ward;
    var docSnapshot = await fieldCollection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      ward = data?['ward'];
    }

    return ward;
  }

//select a ward for visit by field user add each home user to the list of home to collect
  gotoward(ward, panchayath) async {
    ward_visit(ward);
    var querySnapshot = await homeCollection
        .where('panchayath', isEqualTo: panchayath)
        .where('ward', isEqualTo: ward)
        .get();
    for (var user in querySnapshot.docs) {
      var stat = add_collection_history(
          user.reference.id,
          user['name'],
          globfield!.uid,
          ward,
          user['panchayath'],
          user['house'],
          user['house_no']);
      print(stat);
      print(user['name']);
      print(user.reference.id);
    }
  }

//add details of field agent
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

//add details to ward visit history
  Future<void> ward_visit(String ward) async {
    return await visit_history_collection.doc().set({
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
      this.utype = data?['userRole'].toString();
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
        print(admin.name);
        print(admin.panchayath);
        await setadmin(uid, admin.name, admin.email, admin.panchayath,
            admin.phone, admin.empid);
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
      await sethome(uid, home.name, home.email, home.panchayath, home.phone,
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
      await setfield(uid, employ.name, employ.email, employ.panchayath,
          employ.phone, employ.empid);
    }
  }
}

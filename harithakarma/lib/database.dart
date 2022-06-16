import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> addAdmin(String uid, String empid, String Panchayath) async {
    return await adminCollection
        .doc(uid)
        .set({'uid': uid, 'empid': empid, 'panchayath': Panchayath});
  }

  Future<void> addHome(String uid, String Panchayath, String ward,
      String houseno, String owner) async {
    return await homeCollection.doc(uid).set({
      'panchayath': Panchayath,
      'ward': ward,
      'houeno': houseno,
      'owner': owner
    });
  }

  Future<void> addField(String uid, String empid, String Panchayath) async {
    return await fieldCollection
        .doc(uid)
        .set({'empid': empid, 'panchayath': Panchayath});
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
}

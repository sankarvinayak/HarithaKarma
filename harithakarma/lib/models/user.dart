import 'package:shared_preferences/shared_preferences.dart';

class AppUser {
  String? utype;
  String? uid;
  String? name;
  String? email;
  String? panchayath;
  String? phone;
  AppUser.c();
  AppUser(
      this.utype, this.uid, this.email, this.name, this.panchayath, this.phone);
}

class Employee extends AppUser {
  String? empid;

  Employee(super.utype, super.uid, super.email, super.name, super.panchayath,
      super.phone, this.empid);
  Employee.c() : super.c();
}

Employee? globadmin;
setadmin(uid, name, email, panchayath, phone, empid) async {
  globadmin = Employee('Admin', uid, email, name, panchayath, phone, empid);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('empid', empid);
  await prefs.setString('utype', 'Admin');
  await prefs.setString('name', name);
  await prefs.setString('email', email);
  await prefs.setString('panchayath', panchayath);
  await prefs.setString('phone', phone);
  await prefs.setString('uid', uid);
}

initadmin() async {
  final prefs = await SharedPreferences.getInstance();

  final String? empid = prefs.getString('empid');
  const String utype = 'Admin';

  final String? name = prefs.getString('name');

  final String? email = prefs.getString('email');

  final String? panchayath = prefs.getString('panchayath');

  final String? phone = prefs.getString('phone');

  final String? uid = prefs.getString('uid');
  globadmin = Employee(utype, uid, email, name, panchayath, phone, empid);
}

HomeUser? globhome;
sethome(
    uid, name, email, panchayath, phone, wardno, houseno, house, owner) async {
  globhome = HomeUser('Home', uid, email, name, panchayath, phone, house,
      houseno, owner, wardno);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('uid', uid);
  await prefs.setString('utype', 'Home');
  await prefs.setString('name', name);
  await prefs.setString('email', email);
  await prefs.setString('panchayath', panchayath);
  await prefs.setString('phone', phone);
  await prefs.setString('ward', wardno);
  await prefs.setString('house_no', houseno);
  await prefs.setString('house', house);
  await prefs.setString('owner', owner);
}

inithome() async {
  final prefs = await SharedPreferences.getInstance();

  final String? uid = prefs.getString('uid');
  const String utype = 'Home';

  final String? name = prefs.getString('name');

  final String? email = prefs.getString('email');

  final String? panchayath = prefs.getString('panchayath');

  final String? phone = prefs.getString('phone');

  final String? ward = prefs.getString('ward');

  final String? houseNo = prefs.getString('house_no');

  final String? house = prefs.getString('house');

  final String? owner = prefs.getString('owner');
  globhome = HomeUser(
      utype, uid, email, name, panchayath, phone, house, houseNo, owner, ward);
}

Employee? globfield;
setfield(
  uid,
  name,
  email,
  panchayath,
  phone,
  empid,
) async {
  globfield = Employee('Field', uid, email, name, panchayath, phone, empid);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('empid', empid);
  await prefs.setString('utype', 'Field');
  await prefs.setString('name', name);
  await prefs.setString('email', email);
  await prefs.setString('panchayath', panchayath);
  await prefs.setString('phone', phone);
  await prefs.setString('uid', uid);
}

initfield() async {
  final prefs = await SharedPreferences.getInstance();

  final String? empid = prefs.getString('empid');
  const String utype = 'Field';

  final String? name = prefs.getString('name');

  final String? email = prefs.getString('email');

  final String? panchayath = prefs.getString('panchayath');

  final String? phone = prefs.getString('phone');

  final String? uid = prefs.getString('uid');
  globfield = Employee(utype, uid, email, name, panchayath, phone, empid);
}

cleardata() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('uid');
  await prefs.remove('utype');
  await prefs.remove('name');
  globadmin = Employee.c();
  globfield = Employee.c();
  globhome = HomeUser.c();
}

class HomeUser extends AppUser {
  String? wardNo;
  String? houseNo;
  String? house;
  String? owner;

  HomeUser(super.utype, super.uid, super.email, super.name, super.panchayath,
      super.phone, this.house, this.houseNo, this.owner, this.wardNo);
  HomeUser.c() : super.c();
}

unique(values) {
  var set = values.toSet();
  return set.toList();
}

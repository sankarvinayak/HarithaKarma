import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harithakarma/Screens/Adminuser/dashbord.dart';
import 'package:harithakarma/Screens/Fielduser/dashbord.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserHome.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Auth/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();

  final String? utype = prefs.getString('utype');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 23, 75, 7),
  ));
  if (utype == 'Admin') {
    initadmin();
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false, home: SideDrawerAdminHome()));
  } else if (utype == 'Field') {
    initfield();
    runApp(const MaterialApp(
        debugShowCheckedModeBanner: false, home: SideDrawerField()));
  } else if (utype == 'Home') {
    inithome();
    runApp(const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeUserHome()));
  } else {
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
  }
}

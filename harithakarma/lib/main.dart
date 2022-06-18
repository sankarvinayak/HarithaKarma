import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Adminuser/Dashbord.dart';
import 'package:harithakarma/Screens/Fielduser/Dashbord.dart';
import 'package:harithakarma/Screens/Homeuser/Dashbord.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Auth/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();

  final String? utype = prefs.getString('utype');
  if (utype == 'Admin') {
    initadmin();
    runApp(MaterialApp(home: SideDrawerAdminHome()));
  } else if (utype == 'Field') {
    initfield();
    runApp(MaterialApp(home: SideDrawerField()));
  } else if (utype == 'Home') {
    inithome();
    runApp(MaterialApp(home: SideDrawerHome()));
  } else {
    runApp(MaterialApp(home: Login()));
  }
}

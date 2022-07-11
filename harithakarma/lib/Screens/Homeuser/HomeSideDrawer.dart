import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserHistory.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserHome.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserNotifications.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserOrder.dart';
import 'package:harithakarma/Screens/Homeuser/complaints.dart';
import 'package:harithakarma/Screens/Homeuser/profile.dart';
import 'package:harithakarma/Screens/Homeuser/settings.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSideDrawer extends StatefulWidget {
  const HomeSideDrawer({Key? key}) : super(key: key);

  @override
  State<HomeSideDrawer> createState() => _HomeSideDrawerState();
}

class _HomeSideDrawerState extends State<HomeSideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 75, 7),
            ),
            child: Center(
              child: Text(
                'HarithaKarma',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomeUserHome()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text('Order'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomeUserOrder()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const HomeUserHistory()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomeProfile()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Report'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomeUserHome()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const HomeUserNotifications()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
            title: const Text('Complaints'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Complaints()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Setting()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('utype');
              AuthService().signOut();
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Login(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

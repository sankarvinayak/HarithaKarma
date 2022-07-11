import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserHistory.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserOrder.dart';
import 'package:harithakarma/Screens/Homeuser/complaints.dart';
import 'package:harithakarma/Screens/Homeuser/profile.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUserHome extends StatefulWidget {
  const HomeUserHome({Key? key}) : super(key: key);

  @override
  State<HomeUserHome> createState() => _HomeUserHomeState();
}

class _HomeUserHomeState extends State<HomeUserHome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Haritha Karma'),
        backgroundColor: const Color.fromARGB(255, 23, 75, 7),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Image.asset('assets/homeuser/home.jpg'),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: width * .05, vertical: height * 0.075),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeUserOrder()));
                        },
                        child: Column(
                          children: [
                            Icon(Icons.home, size: height * .075),
                            const Text('Request')
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Color.fromARGB(255, 134, 129, 129),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeUserHistory()));
                        },
                        child: Column(
                          children: [
                            Icon(Icons.history, size: height * .075),
                            const Text('History')
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Color.fromARGB(255, 134, 129, 129),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeProfile()));
                        },
                        child: Column(
                          children: [
                            Icon(Icons.person_outline, size: height * .075),
                            const Text('Profile')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeUserHome()));
                        },
                        child: Column(
                          children: [
                            Icon(Icons.report_problem, size: height * .075),
                            const Text('Report')
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Color.fromARGB(255, 134, 129, 129),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Complaints()));
                        },
                        child: Column(
                          children: [
                            Icon(Icons.report_gmailerrorred,
                                size: height * .075),
                            const Text('Complaints')
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Color.fromARGB(255, 134, 129, 129),
                      ),
                      GestureDetector(
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
                        child: Column(
                          children: [
                            Icon(Icons.logout_rounded, size: height * .075),
                            const Text('Logout')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}

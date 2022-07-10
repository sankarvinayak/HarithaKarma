import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserHistory.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserNotifications.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserOrder.dart';
import 'package:harithakarma/Screens/Homeuser/complaints.dart';
import 'package:harithakarma/Screens/Homeuser/profile.dart';
import 'package:harithakarma/Screens/Homeuser/report.dart';
import 'package:harithakarma/Screens/Homeuser/settings.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        backgroundColor: Colors.green.shade900,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Image.asset('assets/homeuser/home.jpg'),
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: width * .05, vertical: height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeUserOrder()));
                    }, // Handle your callback.
                    splashColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              colorFilter: ColorFilter.srgbToLinearGamma(),
                              opacity: 5,
                              image: AssetImage('assets/homeuser/order.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Order'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeUserHistory()));
                    }, // Handle your callback.
                    splashColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/homeuser/history.jpg'),
                              colorFilter: ColorFilter.mode(
                                  Colors.amber, BlendMode.color),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('History'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeProfile()));
                    }, // Handle your callback.
                    splashColor: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/homeuser/profile.png'),
                              colorFilter: ColorFilter.mode(
                                  Color.fromARGB(255, 49, 55, 101),
                                  BlendMode.colorBurn),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('profile'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Report()));
                    }, // Handle your callback.
                    splashColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: const Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/homeuser/report.jpg'),
                              colorFilter: ColorFilter.mode(
                                  Color.fromARGB(255, 214, 60, 29),
                                  BlendMode.color),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Report'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeUserNotifications()));
                    }, // Handle your callback.
                    splashColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: const Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/homeuser/notifications.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Notifications'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Complaints()));
                    }, // Handle your callback.
                    splashColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: const Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/homeuser/complaints.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Complaints'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Setting()));
                    }, // Handle your callback.
                    splashColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: const Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/homeuser/settings.png'),
                              colorFilter: ColorFilter.srgbToLinearGamma(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Settings'),
                      ],
                    ),
                  ),
                  InkWell(
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
                    }, // Handle your callback.
                    splashColor: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        Ink(
                          height: height * 0.2,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              //BoxShadow
                              BoxShadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: const Offset(5.0, 5.0),
                                  blurRadius: 10,
                                  spreadRadius: 5), //BoxShadow
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/homeuser/logout.png'),
                              colorFilter: ColorFilter.mode(
                                  Color.fromARGB(255, 0, 66, 121),
                                  BlendMode.color),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Logout'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ])),
    );
  }
}

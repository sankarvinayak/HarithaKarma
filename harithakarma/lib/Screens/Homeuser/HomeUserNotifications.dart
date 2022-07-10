import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:harithakarma/Screens/Homeuser/HomeSideDrawer.dart';

class HomeUserNotifications extends StatelessWidget {
  const HomeUserNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const HomeSideDrawer(),
        appBar: AppBar(
          title: const Text('Home user'),
          backgroundColor: const Color.fromARGB(255, 23, 75, 7),
        ),
        body: SingleChildScrollView(
            child: Column(children: const [
          Text('No Notifications'),
        ])));
  }
}

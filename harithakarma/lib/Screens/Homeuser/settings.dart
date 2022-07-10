import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:harithakarma/Screens/Homeuser/HomeSideDrawer.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const HomeSideDrawer(),
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: const Color.fromARGB(255, 23, 75, 7),
        ),
        body: SingleChildScrollView());
  }
}

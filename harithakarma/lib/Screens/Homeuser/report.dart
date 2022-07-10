import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:harithakarma/Screens/Homeuser/HomeSideDrawer.dart';

class Report extends StatelessWidget {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const HomeSideDrawer(),
        appBar: AppBar(
          title: const Text('Report'),
          backgroundColor: const Color.fromARGB(255, 23, 75, 7),
        ),
        body: const SingleChildScrollView());
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Shared/netcheck.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Shared/loading.dart';
import '../Homeuser/Dashbord.dart';
import '../Adminuser/Dashbord.dart';
import '../Fielduser/Dashbord.dart';

class fieldProfile extends StatefulWidget {
  @override
  _fieldProfile createState() => _fieldProfile();
}

class _fieldProfile extends State<fieldProfile> {
  bool isedit = false;
  String? email = globfield!.email;
  String? uid = globfield!.uid;
  String? name = globfield!.name;
  String? phone = globfield!.phone;
  String? empid = globfield!.empid;
  String? panchayath = globfield!.panchayath;
  String error = '';
  String success = '';
  // getUser() {
  //   user = DatabaseService().getDetails(uid!, 'Home');
  //   name = user!.name.toString();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isedit
          ? AppBar(
              title: const Text('Edit Profile'),
              backgroundColor: Color.fromARGB(255, 23, 75, 7),
            )
          : AppBar(
              title: const Text('Profile'),
              backgroundColor: Color.fromARGB(255, 23, 75, 7),
              actions: <Widget>[
                //IconButton
                IconButton(
                  icon: const Icon(Icons.edit_note_rounded),
                  onPressed: () async {
                    setState(() {
                      isedit = true;
                    });
                    if (await checkInternet()) {
                    } else {
                      setState(() {
                        error = 'network unavilable';
                      });
                    }
                    ;
                  },
                ), //IconButton
              ],
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 23, 75, 7),
                  fontSize: 20,
                ),
                labelText: 'Name',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = name.toString(),
              onChanged: (text) => {name = text},
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 23, 75, 7),
                  fontSize: 20,
                ),
                labelText: 'Phone',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = phone.toString(),
              onChanged: (text) => {phone = text},
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 23, 75, 7),
                  fontSize: 20,
                ),
                labelText: 'Employee id',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = empid.toString(),
              onChanged: (text) => {empid = text},
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 23, 75, 7),
                  fontSize: 20,
                ),
                labelText: 'Panchayath',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = panchayath.toString(),
              onChanged: (text) => {panchayath = text},
            ),
            SizedBox(
              height: 20.0,
            ),
            isedit
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffEE7B23),
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      if (await checkInternet()) {
                        var result = DatabaseService().addField(
                            name!, email!, uid!, empid!, panchayath!, phone!);
                        if (result != null) {
                          setfield(uid, name, email, panchayath, phone, empid);
                          setState(() {
                            isedit = false;
                            success = "Updated successfully";
                          });
                        }
                      } else {
                        setState(() {
                          error = 'network unavilable';
                        });
                      }
                      ;
                    },
                    child: const Text('Update'),
                  )
                : SizedBox(
                    height: 20.0,
                  ),
            Text(error,
                style: TextStyle(
                    color: Color.fromARGB(255, 218, 25, 11), fontSize: 14.0)),
            Text(success,
                style: TextStyle(
                    color: Color.fromARGB(255, 28, 218, 11), fontSize: 14.0))
          ],
        ),
      ),
    );
  }
}

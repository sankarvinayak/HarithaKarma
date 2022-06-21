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

class homeProfile extends StatefulWidget {
  @override
  _homeProfile createState() => _homeProfile();
}

getname() {
  print(globhome!.name);
  return globhome!.name;
}

class _homeProfile extends State<homeProfile> {
  bool isedit = false;
  String? email = globhome!.email;
  String? uid = globhome!.uid;
  String? name = globhome!.name;
  String? phone = globhome!.phone;
  String? ward_no = globhome!.ward_no;
  String? house_no = globhome!.house_no;
  String? house = globhome!.house;
  String? owner = globhome!.owner;
  String? panchayath = globhome!.panchayath;
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
                    if (await checkInternet()) {
                      setState(() {
                        isedit = true;
                      });
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
                labelText: 'House name',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = house.toString(),
              onChanged: (text) => {house = text},
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
                labelText: 'Ward number',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = ward_no.toString(),
              onChanged: (text) => {ward_no = text},
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
                labelText: 'House number',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = house_no.toString(),
              onChanged: (text) => {house_no = text},
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
              onChanged: (text) => {panchayath = text.toString()},
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
                labelText: 'Owner name',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = owner.toString(),
              onChanged: (text) {
                owner = text;
              },
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
                      print(owner);
                      if (await checkInternet()) {
                        var result = DatabaseService().addHome(
                            name!,
                            email!,
                            uid!,
                            panchayath!,
                            ward_no!,
                            house_no!,
                            owner!,
                            house!,
                            phone!);
                        if (result != null) {
                          sethome(uid, name, email, panchayath, phone, ward_no,
                              house_no, house, owner);
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

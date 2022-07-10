import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Screens/deleteuser.dart';
import 'package:harithakarma/Shared/netcheck.dart';
import 'package:harithakarma/Shared/panchayat_dropdown.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/models/user.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  State<HomeProfile> createState() => _HomeProfile();
}

class _HomeProfile extends State<HomeProfile> {
  bool isedit = false;
  String? email = globhome!.email;
  String? uid = globhome!.uid;
  String? name = globhome!.name;
  String? phone = globhome!.phone;
  String? wardNo = globhome!.wardNo;
  String? houseNo = globhome!.houseNo;
  String? house = globhome!.house;
  String? owner = globhome!.owner;
  String? panchayath = globhome!.panchayath;
  String error = '';
  String success = '';
  // getUser() {
  //   user = DatabaseService().getDetails(uid!, 'Home');
  //   name = user!.name.toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isedit
          ? AppBar(
              title: const Text('Edit Profile'),
              backgroundColor: const Color.fromARGB(255, 23, 75, 7),
            )
          : AppBar(
              title: const Text('Profile'),
              backgroundColor: const Color.fromARGB(255, 23, 75, 7),
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
                  },
                ), //IconButton
              ],
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: const TextStyle(
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
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: const TextStyle(
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
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: const TextStyle(
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
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: const TextStyle(
                  color: Color.fromARGB(255, 23, 75, 7),
                  fontSize: 20,
                ),
                labelText: 'Ward number',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = wardNo.toString(),
              onChanged: (text) => {wardNo = text},
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: const TextStyle(
                  color: Color.fromARGB(255, 23, 75, 7),
                  fontSize: 20,
                ),
                labelText: 'House number',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = houseNo.toString(),
              onChanged: (text) => {houseNo = text},
            ),
            const SizedBox(
              height: 20.0,
            ),
            isedit
                ? Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(style: BorderStyle.solid, width: 0.50),
                    ),
                    child: PanchayatDropDownList(
                      panchayat: (val) {
                        setState(() {
                          panchayath = val.toString();
                        });
                      },
                    ))
                : TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 23, 75, 7),
                        fontSize: 20,
                      ),
                      labelText: 'Panchayath',
                    ),
                    textAlign: TextAlign.center,
                    enabled: isedit,
                    controller: TextEditingController()
                      ..text = panchayath.toString(),
                    onChanged: (text) => {panchayath = text.toString()},
                  ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelStyle: const TextStyle(
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
            const SizedBox(
              height: 20.0,
            ),
            isedit
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffEE7B23),
                      onPrimary: Colors.white,
                    ),
                    onPressed: () async {
                      if (await checkInternet()) {
                        DatabaseService().addHome(
                            name!,
                            email!,
                            uid!,
                            panchayath!,
                            wardNo!,
                            houseNo!,
                            owner!,
                            house!,
                            phone!);

                        sethome(uid, name, email, panchayath, phone, wardNo,
                            houseNo, house, owner);
                        setState(() {
                          isedit = false;
                          success = "Updated successfully";
                        });
                      } else {
                        setState(() {
                          error = 'network unavilable';
                        });
                      }
                    },
                    child: const Text('Update'),
                  )
                : const SizedBox(
                    height: 20.0,
                  ),
            Text(error,
                style: const TextStyle(
                    color: Color.fromARGB(255, 218, 25, 11), fontSize: 14.0)),
            Text(success,
                style: const TextStyle(
                    color: Color.fromARGB(255, 28, 218, 11), fontSize: 14.0)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 143, 1, 1)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text("Warning"),
                            content: const Text(
                                "By doing this your account will be deleted and this change is irriversible"),
                            actions: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 143, 1, 1)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DeleteUser(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Delete account",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("Close"))
                            ],
                          ));
                },
                child: const Text("Delete my account and asociated data"))
          ],
        ),
      ),
    );
  }
}

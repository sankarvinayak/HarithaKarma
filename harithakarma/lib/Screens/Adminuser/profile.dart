import 'package:flutter/material.dart';
import 'package:harithakarma/Shared/netcheck.dart';
import 'package:harithakarma/models/user.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfile();
}

class _AdminProfile extends State<AdminProfile> {
  bool isedit = false;
  String? email = globadmin!.email;
  String? uid = globadmin!.uid;
  String? name = globadmin!.name;
  String? phone = globadmin!.phone;
  String? empid = globadmin!.empid;
  String? panchayath = globadmin!.panchayath;
  String error = '';
  String success = '';
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
                    ;
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
                labelText: 'Employee id',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = empid.toString(),
              onChanged: (text) => {empid = text},
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
                labelText: 'Panchayath',
              ),
              textAlign: TextAlign.center,
              enabled: isedit,
              controller: TextEditingController()..text = panchayath.toString(),
              onChanged: (text) => {panchayath = text.toString()},
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
                        setadmin(uid, name, email, panchayath, phone, empid);
                        setState(() {
                          isedit = false;
                          success = "Updated successfully";
                        });
                      } else {
                        setState(() {
                          error = 'network unavilable';
                        });
                      }
                      ;
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
                    color: Color.fromARGB(255, 28, 218, 11), fontSize: 14.0))
          ],
        ),
      ),
    );
  }
}

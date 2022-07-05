import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Adminuser/complaints.dart';
import 'package:harithakarma/Screens/Adminuser/profile.dart';
import 'package:harithakarma/Screens/Adminuser/users.dart';
import 'package:harithakarma/Screens/Adminuser/ward_details.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Shared/format_timestamp.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/auth.dart';

printpanchayath() {
  print(globadmin?.panchayath);
  return globadmin?.panchayath;
}

class SideDrawerAdminHome extends StatelessWidget {
  String? panchayath = printpanchayath();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _SideDrawer(),
        appBar: AppBar(
          title: Text('Admin'),
          backgroundColor: Color.fromARGB(255, 23, 75, 7),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Todays details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .visit_history_collection
                    .where('panchayath', isEqualTo: globadmin?.panchayath)
                    .where('date', isEqualTo: formatTimestamp(Timestamp.now()))
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ward:" + documentSnapshot['ward']),
                                Text("Agent:" + documentSnapshot['Collector'])
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Overall details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              StreamBuilder(
                stream: DatabaseService()
                    .visit_history_collection
                    .where('panchayath', isEqualTo: globadmin?.panchayath)
                    .orderBy('ward')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    List wardlist = [];
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        if (!wardlist.contains(documentSnapshot['ward'])) {
                          wardlist.add(documentSnapshot['ward']);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ward(documentSnapshot['ward'])));
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    Text("Ward:" + documentSnapshot['ward']),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 0,
                        );
                      },
                    );
                  }

                  return Text("No data");
                },
              ),
            ],
          ),
        ));
  }
}

class _SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'HarithaKarma',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 75, 7),
            ),
          ),
          ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashbord'),
              onTap: () {
                Navigator.of(context).pop();
              }),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Users'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => usertypes()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => adminProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review_outlined),
            title: Text('Complaints'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => complaints_admin()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('utype');
              AuthService().signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Login(),
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

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

class SideDrawerAdminHome extends StatelessWidget {
  final String? panchayath = globadmin?.panchayath;

  SideDrawerAdminHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _SideDrawer(),
        appBar: AppBar(
          title: const Text('Admin'),
          backgroundColor: const Color.fromARGB(255, 23, 75, 7),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Todays details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .visitHistory
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
                                Text("Ward:${documentSnapshot['ward']}"),
                                Text("Agent:${documentSnapshot['Collector']}")
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
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Overall details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              StreamBuilder(
                stream: DatabaseService()
                    .visitHistory
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
                                          Ward(documentSnapshot['ward'])));
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    Text("Ward :${documentSnapshot['ward']}"),
                                  ],
                                ),
                                trailing: const SizedBox(
                                  width: 100,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox(
                          height: 0,
                        );
                      },
                    );
                  }

                  return const Text("No data");
                },
              ),
            ],
          ),
        ));
  }
}

class _SideDrawer extends StatefulWidget {
  @override
  State<_SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<_SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 75, 7),
            ),
            child: Center(
              child: Text(
                'HarithaKarma',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashbord'),
              onTap: () {
                Navigator.of(context).pop();
              }),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Users'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const UserTypes()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AdminProfile()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
            title: const Text('Complaints'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ComplaintsAdmin()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
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
          ),
        ],
      ),
    );
  }
}

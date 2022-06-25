import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Adminuser/profile.dart';
import 'package:harithakarma/Screens/Adminuser/users.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Shared/format_timestamp.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/auth.dart';

printpanchayath() {
  print(globadmin?.panchayath);
  return globadmin?.panchayath;
}

class SideDrawerAdminHome extends StatelessWidget {
  List? wardlist;
  String? panchayath = printpanchayath();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _SideDrawer(),
        appBar: AppBar(
          title: Text('Admin'),
          backgroundColor: Color.fromARGB(255, 23, 75, 7),
        ),
        body: Column(
          children: [
            Text("Todays details"),
            StreamBuilder(
              stream: DatabaseService()
                  .visit_history_collection
                  .where('panchayath', isEqualTo: globadmin?.panchayath)
                  .where('date', isEqualTo: formatTimestamp(Timestamp.now()))
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Wrap(
                            children: [
                              Text("Ward:" + documentSnapshot['ward'] + "   "),
                              Text("Agent:" + documentSnapshot['Collector'])
                            ],
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [],
                            ),
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
            Text("Overall details")
          ],
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

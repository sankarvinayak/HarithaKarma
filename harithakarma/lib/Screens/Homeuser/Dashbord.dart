import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Homeuser/complaints.dart';
import 'package:harithakarma/Screens/Homeuser/profile.dart';
import 'package:harithakarma/Shared/format_timestamp.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawerHome extends StatefulWidget {
  const SideDrawerHome({Key? key}) : super(key: key);

  @override
  State<SideDrawerHome> createState() => _SideDrawerHome();
}

class _SideDrawerHome extends State<SideDrawerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeSideDrawer(),
      appBar: AppBar(
        title: const Text('Home user'),
        backgroundColor: const Color.fromARGB(255, 23, 75, 7),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: DatabaseService()
                  .collectionHistory
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("status", isEqualTo: "arriving today")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  if (streamSnapshot.data!.docs.isNotEmpty) {
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
                            title: Text(
                                "Collection agent:${documentSnapshot['collector_name']}"),
                            subtitle:
                                Text("Status:${documentSnapshot['status']}"),
                          ),
                        );
                      },
                    );
                  } else {
                    return FutureBuilder(
                        future: DatabaseService().checkRequested(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != true) {
                              return ElevatedButton(
                                  onPressed: () async {
                                    await DatabaseService()
                                        .addCollectionRequest();
                                    setState(() {});
                                  },
                                  child:
                                      const Text("Request waste collection"));
                            }
                          }
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Waste collection requested",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        });
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Collection history",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder(
              stream: DatabaseService()
                  .collectionHistory
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("status", isEqualTo: "collected")
                  .orderBy('datetime', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                              "Collected by:${documentSnapshot['collector_name']}"),
                          subtitle: Row(
                            children: [
                              Flexible(
                                child: Text(
                                    "Date: ${formatTimestamp(documentSnapshot['datetime'])}"),
                              )
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
          ],
        ),
      ),
    );
  }
}

class HomeSideDrawer extends StatefulWidget {
  const HomeSideDrawer({Key? key}) : super(key: key);

  @override
  State<HomeSideDrawer> createState() => _HomeSideDrawerState();
}

class _HomeSideDrawerState extends State<HomeSideDrawer> {
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
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomeProfile()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
            title: const Text('Complaints'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Complaints()));
            },
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

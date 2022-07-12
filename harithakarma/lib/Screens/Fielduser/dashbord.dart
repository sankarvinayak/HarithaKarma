import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Screens/Fielduser/profile.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/database.dart';
import '../../service/auth.dart';

class SideDrawerField extends StatefulWidget {
  const SideDrawerField({Key? key}) : super(key: key);

  @override
  @override
  State<SideDrawerField> createState() => _SideDrawerField();
}

class _SideDrawerField extends State<SideDrawerField> {
  dynamic ward;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _SideDrawer(),
        appBar: AppBar(
          title: const Text('Field user'),
          backgroundColor: const Color.fromARGB(255, 23, 75, 7),
        ),
        body: Center (
          child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Wards details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder(
              stream: DatabaseService()
                  .collectionHistory
                  .where('collector',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("status", isEqualTo: "arriving today")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  if (streamSnapshot.data!.docs.isEmpty) {
                    return FutureBuilder(
                        future: DatabaseService().getWardDetails(
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: ((context, snapshot) {
                          if (snapshot.data != null) {
                            ward = snapshot.data;
                            if (ward.length == 0) {
                              return const Text("No ward assigned yet");
                            } else {
                              return Flexible(
                                child: ListView(
                                    children: ward
                                        .map<Widget>((ward) => Card(
                                              margin: const EdgeInsets.all(7),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Ward:$ward"),
                                                    FutureBuilder(
                                                        future: DatabaseService()
                                                            .getWardRequestCount(
                                                                ward),
                                                        builder: ((context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                                "Request:${snapshot.data.toString()}");
                                                          }
                                                          return const CircularProgressIndicator();
                                                        })),
                                                    FutureBuilder(
                                                        future:
                                                            DatabaseService()
                                                                .getLastvisited(
                                                                    ward),
                                                        builder: ((context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                                "visit:${snapshot.data.toString()}");
                                                          }
                                                          return const CircularProgressIndicator();
                                                        })),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          await DatabaseService()
                                                              .gotoward(
                                                                  ward,
                                                                  globfield!
                                                                      .panchayath);
                                                          setState(() {});
                                                        },
                                                        child: const Text("Go"))
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList()),
                              );
                            }
                          }
                          return const Text("No data available");
                        }));
                  } else {
                    return Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ExpansionTileCard(
                              title:
                                  Text("Owner : ${documentSnapshot['name']}"),
                              subtitle:
                                  Text("ward : ${documentSnapshot['ward']}"),
                              children: [
                                Text(
                                    "House name : ${documentSnapshot['house']}"),
                                ElevatedButton(
                                    onPressed: () {
                                      DatabaseService().updateCollectionStatus(
                                          documentSnapshot.reference.id);
                                    },
                                    child: const Text("Collected"))
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                return const Center(
                  child: Text("No data available"),
                );
              },
            ),
          ],
        )));
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
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const FieldProfile()));
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Screens/Fielduser/profile.dart';
import 'package:harithakarma/main.dart';
import 'package:harithakarma/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/database.dart';
import '../../service/auth.dart';

class SideDrawerField extends StatefulWidget {
  @override
  @override
  _SideDrawerField createState() => _SideDrawerField();
}

class _SideDrawerField extends State<SideDrawerField> {
  var ward;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _SideDrawer(),
        appBar: AppBar(
          title: Text('Field user'),
          backgroundColor: Color.fromARGB(255, 23, 75, 7),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Wards details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                stream: DatabaseService()
                    .collection_historycollection
                    .where('collector',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("status", isEqualTo: "arriving today")
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    if (streamSnapshot.data!.docs.length == 0) {
                      return FutureBuilder(
                          future: DatabaseService().getWardDetails(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: ((context, snapshot) {
                            if (snapshot.data != null) {
                              ward = snapshot.data;
                              if (ward.length == 0) {
                                return Text("No ward assigned yet");
                              } else {
                                return Flexible(
                                  child: ListView(
                                      children: ward
                                          .map<Widget>((ward) => Container(
                                                  child: Card(
                                                margin: const EdgeInsets.all(7),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Ward:" + ward),
                                                      FutureBuilder(
                                                          future: DatabaseService()
                                                              .get_ward_requet_count(
                                                                  ward),
                                                          builder: ((context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return Text(
                                                                  "Request:" +
                                                                      snapshot
                                                                          .data
                                                                          .toString());
                                                            }
                                                            return CircularProgressIndicator();
                                                          })),
                                                      FutureBuilder(
                                                          future: DatabaseService()
                                                              .get_lastvisited(
                                                                  ward),
                                                          builder: ((context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return Text("visit:" +
                                                                  snapshot.data
                                                                      .toString());
                                                            }
                                                            return CircularProgressIndicator();
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
                                                          child: Text("Go"))
                                                    ],
                                                  ),
                                                ),
                                              )))
                                          .toList()),
                                );
                              }
                            }
                            return Text("No data available");
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
                                    Text("Owner : " + documentSnapshot['name']),
                                subtitle:
                                    Text("ward : " + documentSnapshot['ward']),
                                children: [
                                  Text("House name : " +
                                      documentSnapshot['house']),
                                  ElevatedButton(
                                      onPressed: () {
                                        print(documentSnapshot.reference.id);
                                        DatabaseService()
                                            .update_collection_status(
                                                documentSnapshot.reference.id);
                                      },
                                      child: Text("Collected"))
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  ;
                  return const Center(
                    child: Text("No data available"),
                  );
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
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => fieldProfile()));
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

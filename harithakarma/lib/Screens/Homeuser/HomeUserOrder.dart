import 'package:harithakarma/Screens/Homeuser/HomeSideDrawer.dart';
import 'package:harithakarma/Screens/Homeuser/complaints.dart';
import 'package:harithakarma/Screens/Homeuser/profile.dart';
import 'package:harithakarma/Shared/format_timestamp.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeUserOrder extends StatefulWidget {
  const HomeUserOrder({Key? key}) : super(key: key);

  @override
  State<HomeUserOrder> createState() => _SideDrawerHome();
}

class _SideDrawerHome extends State<HomeUserOrder> {
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
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            title:
                                                const Text("Confirm request"),
                                            content: const Text(
                                                "Confirm request for waste collection"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text("cancel")),
                                              TextButton(
                                                  onPressed: () async {
                                                    await DatabaseService()
                                                        .addCollectionRequest();
                                                    setState(() {});
                                                  },
                                                  child: const Text("Confirm"))
                                            ],
                                          ));
                                },
                                child: const Text("Request waste collection"),
                              );
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
          ],
        ),
      ),
    );
  }
}

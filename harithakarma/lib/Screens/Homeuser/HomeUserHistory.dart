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

class HomeUserHistory extends StatefulWidget {
  const HomeUserHistory({Key? key}) : super(key: key);

  @override
  State<HomeUserHistory> createState() => _HomeUserHistoryState();
}

class _HomeUserHistoryState extends State<HomeUserHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeSideDrawer(),
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: const Color.fromARGB(255, 23, 75, 7),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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

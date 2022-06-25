import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';

class complaints_admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 23, 75, 7),
          title: const Text('Complaints'),
        ),
        body: StreamBuilder(
          stream: DatabaseService()
              .complaintscollection
              .where('panchayath', isEqualTo: globadmin!.panchayath)
              .where('status', isEqualTo: "pending")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(documentSnapshot['title']),
                          subtitle: SizedBox(
                            width: 100,
                            child: Wrap(
                              children: [Text(documentSnapshot['desc'])],
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffEE7B23),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () {
                              print(documentSnapshot.reference.id);
                              DatabaseService().update_complaint_status(
                                  documentSnapshot.reference.id);
                            },
                            child: Text("Close"))
                      ],
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/models/user.dart';

class reportAdmin extends StatelessWidget {
  const reportAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 23, 75, 7),
          title: const Text('waste dump report'),
        ),
        body: StreamBuilder(
          stream: DatabaseService()
              .report
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
                          title: Text("Title:${documentSnapshot['title']}"),
                          subtitle: SizedBox(
                            width: 100,
                            child: Wrap(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                        textAlign: TextAlign.left,
                                        "Description:${documentSnapshot['desc']}"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Ward:${documentSnapshot['ward']}"),
                                        Text(
                                            "Landmark:${documentSnapshot['location']}")
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffEE7B23),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () {
                              DatabaseService().updateReportStatus(
                                  documentSnapshot.reference.id);
                            },
                            child: const Text("Close"))
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

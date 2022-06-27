import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';

class ward extends StatelessWidget {
  String? ward_no;
  ward(String ward_no) {
    this.ward_no = ward_no;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 75, 7),
        title: Text("Ward " + ward_no!),
      ),
      body: StreamBuilder(
        stream: DatabaseService()
            .visit_history_collection
            .orderBy('date', descending: true)
            .where('panchayath', isEqualTo: globadmin!.panchayath)
            .where('ward', isEqualTo: ward_no)
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
                  child: ListTile(
                    title: Text(documentSnapshot['Collector']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(documentSnapshot['date']),
                          )
                        ],
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
    );
  }
}

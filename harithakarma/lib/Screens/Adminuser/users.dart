import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';

class usertypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                backgroundColor: Color.fromARGB(255, 23, 75, 7),
                title: Text('Users'),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.home_outlined), text: 'Home users'),
                    Tab(icon: Icon(Icons.assignment_ind), text: 'Field agents'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              StreamBuilder(
                stream: DatabaseService()
                    .getHomeReference()
                    .where('panchayath', isEqualTo: globadmin!.panchayath)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ExpansionTileCard(
                            expandedColor: Color.fromARGB(255, 185, 221, 155),
                            baseColor: Color.fromARGB(255, 204, 235, 211),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            title: Text(documentSnapshot['name']),
                            subtitle: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Ward Number:" + documentSnapshot['ward'])),
                            children: [
                              Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                        vertical: 5.0,
                                      ),
                                      child: Text("Owner:" +
                                          documentSnapshot['owner']))),
                              Text("House Number:" +
                                  documentSnapshot['house_no']),
                              Text("House Name:" + documentSnapshot['house']),
                              Text("Phone:" + documentSnapshot['phone']),
                            ],
                            // margin: const EdgeInsets.all(10),
                            // child: ListTile(
                            //   title: Text(documentSnapshot['name']),
                            //   trailing: SizedBox(
                            //     width: 100,
                            //     child: Row(
                            //       children: [],
                            //     ),
                            //   ),
                            // ),
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
              StreamBuilder(
                stream: DatabaseService()
                    .getFieldReference()
                    .where('panchayath', isEqualTo: globadmin!.panchayath)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        String ward;
                        try {
                          ward = documentSnapshot['ward'];
                        } catch (e) {
                          ward = "No ward assigned";
                        }

                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ExpansionTileCard(
                            title: Text(documentSnapshot['name']),
                            subtitle: Text(
                                "Employee id:" + documentSnapshot['empid']),
                            children: [
                              Text(ward),
                              ElevatedButton(
                                onPressed: () {
                                  print(documentSnapshot.reference.id);
                                  print(ward);
                                },
                                child: Text("+"),
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder()),
                              )
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

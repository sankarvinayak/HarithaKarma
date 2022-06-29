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
                    .homeCollection
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
                        return Container(
                          margin: const EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ExpansionTileCard(
                              expandedColor: Color.fromARGB(255, 228, 253, 187),
                              baseColor: Color.fromARGB(255, 204, 235, 211),

                              title: Text(documentSnapshot['name']),
                              subtitle: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Ward Number:" +
                                      documentSnapshot['ward'])),
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
                    .fieldCollection
                    .where('panchayath', isEqualTo: globadmin!.panchayath)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    bool is_assigned = true;
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        var ward;
                        try {
                          ward = documentSnapshot['ward'].toString();
                          print(ward);
                          is_assigned = true;
                        } catch (e) {
                          ward = "No ward assigned";
                          is_assigned = false;
                        }
                        // if (ward == '') {
                        //   ward = "No ward assigned";
                        // }

                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ExpansionTileCard(
                            title: Text(documentSnapshot['name']),
                            subtitle: Text(
                                "Employee id:" + documentSnapshot['empid']),
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text("Wards assigned:" +
                                        (is_assigned
                                            ? ward
                                                .toString()
                                                .substring(1,
                                                    ward.toString().length - 1)
                                                .replaceAll(' ', '')
                                            : ward)),
                                    Container(
                                      //margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),

                                      child: ElevatedButton(
                                        onPressed: () {
                                          bool isedit = false;
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        "Edit wards assigned"),
                                                    content: ward.compareTo(
                                                                "No ward assigned") !=
                                                            0
                                                        ? TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        "wards seperated by comma"),
                                                            controller: TextEditingController()
                                                              ..text = ward
                                                                  .toString()
                                                                  .substring(
                                                                      1,
                                                                      ward.toString().length -
                                                                          1)
                                                                  .replaceAll(
                                                                      ' ', ''),
                                                            onChanged: (text) =>
                                                                {
                                                              ward = text,
                                                              isedit = true
                                                            },
                                                          )
                                                        : TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        "wards seperated by comma"),
                                                            onChanged: (text) =>
                                                                {
                                                                  ward = text,
                                                                  isedit = true
                                                                }),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            if (isedit) {
                                                              DatabaseService().set_ward(
                                                                  documentSnapshot
                                                                      .reference
                                                                      .id,
                                                                  ward.split(
                                                                      ','));
                                                            }

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Submit'))
                                                    ],
                                                  ));
                                          print(documentSnapshot.reference.id);
                                          print(ward);
                                        },
                                        child: Text("Edit"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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

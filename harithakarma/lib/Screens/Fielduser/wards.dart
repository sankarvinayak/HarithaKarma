import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/models/user.dart';

class wards extends StatelessWidget {
  var ward;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // body: StreamBuilder(
        //     stream: Stream.fromFuture(
        //         DatabaseService().getWardDetails(globfield!.uid)),
        //     builder: ((context, snapshot) {
        //       print(snapshot);
        //       return Text(snapshot.data['ward']);
        //     })),
        body: Container(
          child: Column(
            children: [
              Text("Wards assigned"),
              FutureBuilder(
                  future: DatabaseService().getWardDetails(globfield!.uid),
                  builder: ((context, snapshot) {
                    if (snapshot.data != null) {
                      ward = snapshot.data;
                      if (ward == '') {
                        return Text("No ward assigned yet");
                      } else {
                        return Expanded(
                          child: ListView(
                              children: ward
                                  .map<Widget>((ward) => Container(
                                          child: Card(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(ward),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text("Go"))
                                          ],
                                        ),
                                      )))
                                  .toList()),
                        );
                      }
                    }
                    return CircularProgressIndicator();
                  })),
            ],
          ),
        )
        // StreamBuilder(
        //   stream: DatabaseService().getFieldReference().snapshots(y),
        //   builder: (context, AsyncSnapshot streamSnapshot) {
        //     if (streamSnapshot.hasData) {
        //       try {
        //         ward = streamSnapshot.data!.docs[0]['ward']
        //             .toString()
        //             .split(',');
        //       } catch (e) {
        //         ward = null;
        //       }
        //       if (ward != null) {
        //         return ListView.builder(
        //           itemBuilder: ((context, index) {
        //             return Text(ward[index]);
        //           }),
        //         );
        //       }

        //       // return ListView.builder(
        //       //   itemCount: streamSnapshot.data!.docs.length,
        //       //   itemBuilder: (context, index) {
        //       //     final DocumentSnapshot documentSnapshot =
        //       //         streamSnapshot.data!.docs[index];
        //       //     return Padding(
        //       //       padding: const EdgeInsets.all(1.0),
        //       //       child: ExpansionTileCard(
        //       //         expandedColor: Color.fromARGB(255, 185, 221, 155),
        //       //         baseColor: Color.fromARGB(255, 204, 235, 211),
        //       //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
        //       //         title: Text(documentSnapshot['name']),
        //       //         subtitle: Align(
        //       //             alignment: Alignment.centerLeft,
        //       //             child: Text(
        //       //                 "Ward Number:" + documentSnapshot['ward'])),
        //       //         children: [
        //       //           Divider(
        //       //             thickness: 1.0,
        //       //             height: 1.0,
        //       //           ),
        //       //           Align(
        //       //               alignment: Alignment.centerLeft,
        //       //               child: Padding(
        //       //                   padding: const EdgeInsets.symmetric(
        //       //                     horizontal: 5.0,
        //       //                     vertical: 5.0,
        //       //                   ),
        //       //                   child: Text(
        //       //                       "Owner:" + documentSnapshot['owner']))),
        //       //           Text("House Number:" + documentSnapshot['house_no']),
        //       //           Text("House Name:" + documentSnapshot['house']),
        //       //           Text("Phone:" + documentSnapshot['phone']),
        //       //         ],
        //       //         // margin: const EdgeInsets.all(10),
        //       //         // child: ListTile(
        //       //         //   title: Text(documentSnapshot['name']),
        //       //         //   trailing: SizedBox(
        //       //         //     width: 100,
        //       //         //     child: Row(
        //       //         //       children: [],
        //       //         //     ),
        //       //         //   ),
        //       //         // ),
        //       //       ),
        //       //     );
        //       //   },
        //       // );
        //     }

        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }
}

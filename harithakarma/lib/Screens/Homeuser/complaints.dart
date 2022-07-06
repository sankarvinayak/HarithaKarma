import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/models/user.dart';

class complaints extends StatefulWidget {
  @override
  _complaints createState() => _complaints();
}

class _complaints extends State<complaints> {
  String? title;
  String? desc;
  bool issubmit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 75, 7),
        title: const Text('Complaints'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelStyle: TextStyle(
                    color: Color.fromARGB(255, 23, 75, 7),
                    fontSize: 20,
                  ),
                  labelText: 'Title',
                ),
                textAlign: TextAlign.left,
                enabled: true,
                onChanged: (text) => {title = text},
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelStyle: TextStyle(
                    color: Color.fromARGB(255, 23, 75, 7),
                    fontSize: 20,
                  ),
                  labelText: 'Description',
                ),
                textAlign: TextAlign.left,
                enabled: true,
                onChanged: (text) => {desc = text},
              ),
              SizedBox(
                height: 20,
              ),
              issubmit
                  ? Text("Complaint submitted")
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffEE7B23),
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        if (DatabaseService().addComplaint(
                                title!, desc!, globhome!.wardNo) !=
                            null) {
                          setState(() {
                            issubmit = true;
                          });
                        }
                        ;
                      },
                      child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}

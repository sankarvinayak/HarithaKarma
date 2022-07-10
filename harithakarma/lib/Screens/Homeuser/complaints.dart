import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Homeuser/HomeSideDrawer.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/models/user.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _Complaints();
}

class _Complaints extends State<Complaints> {
  String? title;
  String? desc;
  bool issubmit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeSideDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 75, 7),
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
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromARGB(255, 23, 75, 7),
                    fontSize: 20,
                  ),
                  labelText: 'Title',
                ),
                textAlign: TextAlign.left,
                enabled: true,
                onChanged: (text) => {title = text},
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromARGB(255, 23, 75, 7),
                    fontSize: 20,
                  ),
                  labelText: 'Description',
                ),
                textAlign: TextAlign.left,
                enabled: true,
                onChanged: (text) => {desc = text},
              ),
              const SizedBox(
                height: 20,
              ),
              issubmit
                  ? const Text("Complaint submitted")
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffEE7B23),
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        DatabaseService()
                            .addComplaint(title!, desc!, globhome!.wardNo);
                        {
                          setState(() {
                            issubmit = true;
                          });
                        }
                      },
                      child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}

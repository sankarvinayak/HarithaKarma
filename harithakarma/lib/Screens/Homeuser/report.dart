import 'package:flutter/material.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/models/user.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);

  @override
  State<report> createState() => _Complaints();
}

class _Complaints extends State<report> {
  String? title;
  String? desc;
  String? location;
  String? ward;
  bool issubmit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 75, 7),
        title: const Text('Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 20,
              ),
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
                  labelText: 'Ward',
                ),
                textAlign: TextAlign.left,
                enabled: true,
                onChanged: (text) => {ward = text},
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromARGB(255, 23, 75, 7),
                    fontSize: 20,
                  ),
                  labelText: 'Landmark',
                ),
                textAlign: TextAlign.left,
                enabled: true,
                onChanged: (text) => {location = text},
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
                            .report_waste(title!, desc!, ward, location);
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

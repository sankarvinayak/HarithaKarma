import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';
import 'Homeuser/Dashbord.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.45,
                child: Image.asset(
                  'assets/waste-management.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Panchayath/Muncipality/Corperation',
              //     suffixIcon: Icon(Icons.location_city),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30.0,
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Ward',
              //     suffixIcon: Icon(Icons.location_on),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30.0,
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'House Number',
              //     suffixIcon: Icon(Icons.home),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 30.0,
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Owner name',
              //     suffixIcon: Icon(Icons.person),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forget password?',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffEE7B23),
                        onPrimary: Colors.white,
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SideDrawerHome()));
                          }
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          showSpinner = false;
                        });

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             SideDrawerHome()));
                      },
                      child: Text('Register'),
                    )
                  ],
                ),
              ),
              SizedBox(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Text.rich(
                  TextSpan(text: 'Already have an account ', children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Color(0xffEE7B23)),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

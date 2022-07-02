import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/service/auth.dart';
import '../../Shared/loading.dart';
import 'signup.dart';
import '../Homeuser/Dashbord.dart';
import '../Adminuser/Dashbord.dart';
import '../Fielduser/Dashbord.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String text = '';
  bool loading = false;
  String email = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : Scaffold(
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
                            'Reset Password',
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
                      decoration: InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(text,
                        style:
                            TextStyle(color: Color.fromARGB(255, 16, 94, 16))),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffEE7B23),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.sendPasswordResetEmail(email);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  text =
                                      "Password reset email send if there is a registered account";
                                });
                              }
                            },
                            child: Text('Send password reset email'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text.rich(
                        TextSpan(text: 'Don\'t have an account ', children: [
                          TextSpan(
                            text: 'Regsiter',
                            style: TextStyle(color: Color(0xffEE7B23)),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

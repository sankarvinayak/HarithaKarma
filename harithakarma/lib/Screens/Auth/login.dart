import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/resetpassword.dart';
import 'package:harithakarma/Shared/custom_wigdets/InputBox.dart';
import 'package:harithakarma/Shared/custom_wigdets/PasswordBox.dart';
import 'package:harithakarma/database.dart';
import 'package:harithakarma/service/auth.dart';
import '../../Shared/loading.dart';
import 'signup.dart';
import '../Homeuser/Dashbord.dart';
import '../Adminuser/Dashbord.dart';
import '../Fielduser/Dashbord.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String email = '';
  String password = '';
  dynamic result = null;
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
                            'Login',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    InputBox(
                        onChange: (val) {
                          setState(() => email = val);
                        },
                        regexValue: RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                        specifiedIcon: Icons.email,
                        label: 'Email',
                        errorText: 'enter a vaild email',
                        keyboard: TextInputType.emailAddress),
                    SizedBox(
                      height: 20.0,
                    ),
                    PasswordBox(
                        onChange: (val) {
                          setState(() => password = val);
                        },
                        regexValue: RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassword()));
                            },
                            child: Text.rich(
                              TextSpan(text: 'Forget password? ', children: []),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffEE7B23),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              print(email);
                              print(password);
                              setState(() => loading = true);
                              try {
                                result = await _auth.SignIn(email, password);

                                await DatabaseService().getDetails(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    result);

                                if (result == "Admin") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SideDrawerAdminHome()));
                                } else if (result == "Field") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SideDrawerField()));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SideDrawerHome()));
                                }
                              } catch (e) {
                                setState(() {
                                  loading = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: Text("Error occured"),
                                          content: Text(e.toString()),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text("Close"))
                                          ],
                                        ));
                              }
                            },
                            child: Text('Login'),
                          )
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

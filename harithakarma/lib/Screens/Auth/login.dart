import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/resetpassword.dart';
import 'package:harithakarma/Shared/custom_wigdets/InputBox.dart';
import 'package:harithakarma/Shared/custom_wigdets/PasswordBox.dart';
import 'package:harithakarma/service/database.dart';
import 'package:harithakarma/service/auth.dart';
import '../../Shared/loading.dart';
import 'signup.dart';
import '../Homeuser/Dashbord.dart';
import '../Adminuser/Dashbord.dart';
import '../Fielduser/Dashbord.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final AuthService _auth = AuthService();
  String error = '';
  bool loading = false;
  String email = '';
  String password = '';
  dynamic result;
  bool validEmail = false;
  bool validPassword = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : Scaffold(
            body: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
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
                        children: const [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    InputBox(
                        onChange: (val) {
                          setState(() => email = val);
                        },
                        isValid: (val) {
                          setState(() {
                            validEmail = val;
                          });
                        },
                        regexValue: RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                        specifiedIcon: Icons.email,
                        label: 'Email',
                        errorText: 'enter a vaild email',
                        keyboard: TextInputType.emailAddress),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PasswordBox(
                        onChange: (val) {
                          setState(() => password = val);
                        },
                        isValid: (val) {
                          setState(() {
                            validPassword = val;
                          });
                        },
                        regexValue: RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')),
                    const SizedBox(
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
                            child: const Text.rich(
                              TextSpan(text: 'Forget password? ', children: []),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffEE7B23),
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              if (email != '' && password != '') {
                                print(email);
                                print(validEmail);

                                print(password);
                                print(validPassword);

                                setState(() => loading = true);
                                try {
                                  result = await _auth.signIn(email, password);

                                  await DatabaseService().getDetails(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      result);
                                  if (!mounted) return;
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
                                            title: const Text("Error occured"),
                                            content: Text(e.toString()),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text("Close"))
                                            ],
                                          ));
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: const Text("Error occured"),
                                          content: const Text(
                                              "Enter username and password"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text("Close"))
                                          ],
                                        ));
                              }
                            },
                            child: const Text('Login'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: const Text.rich(
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

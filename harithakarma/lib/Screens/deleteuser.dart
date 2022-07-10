import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Auth/login.dart';
import 'package:harithakarma/Shared/custom_wigdets/inputbox.dart';
import 'package:harithakarma/Shared/custom_wigdets/passwordbox.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:harithakarma/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteUser extends StatefulWidget {
  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  final AuthService _auth = AuthService();

  String? email;

  String? password;

  dynamic result;

  bool validEmail = false;

  bool validPassword = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete user account'),
        backgroundColor: const Color.fromARGB(255, 23, 75, 7),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Delete user account',
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () async {
                          if (email != null && password != null && validEmail) {
                            // print(email);
                            // print(validEmail);

                            // print(password);
                            // print(validPassword);
                            try {
                              await _auth.relogin(email!, password!);
                              DatabaseService().deleteuser();
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('utype');
                              AuthService().signOut();
                              if (!mounted) return;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Login(),
                                ),
                                (route) => false,
                              );
                            } catch (e) {
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
                                          "Enter valid username and password"),
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
                        child: const Text('Delete account and associated data'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

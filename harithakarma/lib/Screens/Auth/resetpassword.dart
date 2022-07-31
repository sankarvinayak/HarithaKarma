import 'package:flutter/material.dart';
import 'package:harithakarma/Shared/custom_wigdets/inputbox.dart';
import 'package:harithakarma/service/auth.dart';
import '../../Shared/loading.dart';
import 'signup.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final AuthService _auth = AuthService();
  String text = '';
  bool loading = false;
  String email = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return loading
        ? const Loading()
        : Scaffold(
            body: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: width * .75,
                      height: height * 0.35,
                      child: Image.asset(
                        'assets/icon.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Reset Password',
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
                        isValid: (val) {},
                        regexValue: RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                        specifiedIcon: Icons.email,
                        label: 'Email id',
                        errorText: 'enter a vaild email',
                        keyboard: TextInputType.emailAddress),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(text,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 16, 94, 16))),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffEE7B23),
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
                            child: const Text('Send password reset email'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup()));
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

import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Adminuser/dashbord.dart';
import 'package:harithakarma/Screens/Auth/resetpassword.dart';
import 'package:harithakarma/Screens/Homeuser/HomeUserHome.dart';
import 'package:harithakarma/Shared/custom_wigdets/inputbox.dart';
import 'package:harithakarma/Shared/custom_wigdets/passwordbox.dart';
import 'package:harithakarma/Shared/panchayat_dropdown.dart';
import 'package:harithakarma/models/user.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:harithakarma/Screens/Fielduser/dashbord.dart';
import 'package:harithakarma/Shared/loading.dart';
import 'package:harithakarma/service/database.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  final AuthService _auth = AuthService();
  String? phone;
  String? house;
  String? email;
  String? password;
  String? name;
  bool isLoading = false;
  String? _userType;
  String? _panchayath;
  String? empid;
  String? wardno;
  String? houseno;
  String? owner;
  String? newUser;
  bool validEmail = false;
  bool validPassword = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isLoading
        ? const Loading()
        : Scaffold(
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
                        height: 60,
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
                              'Register',
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
                            email = val;
                          },
                          regexValue: RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                          specifiedIcon: Icons.email_outlined,
                          label: 'Email',
                          errorText: 'enter valid email address',
                          keyboard: TextInputType.emailAddress,
                          isValid: (val) {
                            setState(() => validEmail = val);
                          }),
                      const SizedBox(
                        height: 30.0,
                      ),
                      PasswordBox(
                          onChange: (val) {
                            setState(() => password = val);
                          },
                          isValid: (val) {
                            setState(() {
                              setState(() => validPassword = val);
                            });
                          },
                          regexValue: RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')),
                      const SizedBox(
                        height: 30.0,
                      ),
                      InputBox(
                          onChange: (val) {
                            name = val;
                          },
                          regexValue: RegExp(r'^[a-z A-Z]+$'),
                          specifiedIcon: Icons.person,
                          label: 'Name',
                          errorText: 'enter valid name',
                          keyboard: TextInputType.name,
                          isValid: (val) {
                            setState(() => validEmail = val);
                          }),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border:
                              Border.all(style: BorderStyle.solid, width: 0.50),
                        ),
                        child: DropdownButton(
                          hint: Container(
                            alignment: Alignment.center,
                            child: _userType == null
                                ? const Text('User')
                                : Text(
                                    _userType!,
                                  ),
                          ),
                          isExpanded: true,
                          iconSize: 40.0,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17.0),
                          items: ['Home', 'Field', 'Admin'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _panchayath = null;
                                _userType = val.toString();
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      InputBox(
                          onChange: (val) {
                            phone = val;
                          },
                          regexValue: RegExp(r'^[0-9]{10}$'),
                          specifiedIcon: Icons.phone,
                          label: 'Phone',
                          errorText: 'enter valid phone no',
                          keyboard: TextInputType.phone,
                          isValid: (val) {}),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _userType == "Admin"
                          ? (Column(
                              children: <Widget>[
                                InputBox(
                                    onChange: (val) {
                                      empid = val;
                                    },
                                    regexValue: RegExp(r'^[0-9]{10}$'),
                                    specifiedIcon: Icons.document_scanner,
                                    label: 'Employee ID',
                                    errorText: 'enter valid id',
                                    keyboard: TextInputType.number,
                                    isValid: (val) {}),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                InputBox(
                                    onChange: (val) {
                                      _panchayath = val;
                                    },
                                    regexValue: RegExp(r'^[a-z A-Z]{4,}$'),
                                    specifiedIcon: Icons.location_city,
                                    label:
                                        'Panchayath/Muncipality/Corperation name',
                                    errorText: '',
                                    keyboard: TextInputType.name,
                                    isValid: (val) {}),
                              ],
                            ))
                          : _userType == "Field"
                              ? (Column(
                                  children: <Widget>[
                                    InputBox(
                                        onChange: (val) {
                                          empid = val;
                                        },
                                        regexValue: RegExp(r'^[0-9]{10}$'),
                                        specifiedIcon: Icons.document_scanner,
                                        label: 'Employee ID',
                                        errorText: 'enter valid id',
                                        keyboard: TextInputType.number,
                                        isValid: (val) {}),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    Container(
                                        height: 60,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              width: 0.50),
                                        ),
                                        child: PanchayatDropDownList(
                                          panchayat: (val) {
                                            setState(() {
                                              _panchayath = val.toString();
                                            });
                                          },
                                        )),
                                  ],
                                ))
                              : (Column(
                                  children: [
                                    Container(
                                        height: 60,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              width: 0.50),
                                        ),
                                        child: PanchayatDropDownList(
                                          panchayat: (val) {
                                            setState(() {
                                              _panchayath = val.toString();
                                            });
                                          },
                                        )),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    InputBox(
                                        onChange: (val) {
                                          wardno = val;
                                        },
                                        regexValue: RegExp(r'^[0-9]{1,2}$'),
                                        specifiedIcon: Icons.apartment,
                                        label: 'Ward Number',
                                        errorText: 'enter valid ward number',
                                        keyboard: TextInputType.number,
                                        isValid: (val) {}),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    InputBox(
                                        onChange: (val) {
                                          houseno = val;
                                        },
                                        regexValue: RegExp(r'^[0-9]{1,4}$'),
                                        specifiedIcon: Icons.house,
                                        label: 'House Number',
                                        errorText: 'enter valid house number',
                                        keyboard: TextInputType.number,
                                        isValid: (val) {}),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    InputBox(
                                        onChange: (val) {
                                          house = val;
                                        },
                                        regexValue: RegExp(r'^[a-z A-Z]+$'),
                                        specifiedIcon: Icons.home_filled,
                                        label: 'House Name',
                                        errorText: 'enter valid House name',
                                        keyboard: TextInputType.name,
                                        isValid: (val) {
                                          setState(() => validEmail = val);
                                        }),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    InputBox(
                                        onChange: (val) {
                                          owner = val;
                                        },
                                        regexValue: RegExp(r'^[a-z A-Z]+$'),
                                        specifiedIcon: Icons.person_outline,
                                        label: 'House Owner name',
                                        errorText: 'enter valid name',
                                        keyboard: TextInputType.name,
                                        isValid: (val) {
                                          setState(() => validEmail = val);
                                        }),
                                  ],
                                )),
                      const SizedBox(
                        height: 20.0,
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
                                        builder: (context) =>
                                            const ResetPassword()));
                              },
                              child: const Text.rich(
                                TextSpan(
                                    text: 'Forget password? ', children: []),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xffEE7B23),
                                onPrimary: Colors.white,
                              ),
                              onPressed: () async {
                                if (validEmail &&
                                    validPassword &&
                                    name != null &&
                                    _userType != null) {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    newUser = await _auth.signUpEmail(
                                        email!, password!, name!, _userType!);

                                    if (newUser != null) {
                                      if (_userType == 'Admin') {
                                        setadmin(newUser, name, email,
                                            _panchayath, phone, empid);
                                        DatabaseService().addAdmin(
                                            name!,
                                            email!,
                                            newUser!,
                                            empid!,
                                            _panchayath!,
                                            phone!);
                                        if (!mounted) return;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        SideDrawerAdminHome()));
                                      } else if (_userType == 'Field') {
                                        setfield(newUser, name, email,
                                            _panchayath, phone, empid);
                                        DatabaseService().addField(
                                            name!,
                                            email!,
                                            newUser!,
                                            empid!,
                                            _panchayath!,
                                            phone!);
                                        if (!mounted) return;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const SideDrawerField()));
                                      } else {
                                        sethome(
                                            newUser,
                                            name,
                                            email,
                                            _panchayath,
                                            phone,
                                            wardno,
                                            houseno,
                                            house,
                                            owner);
                                        DatabaseService().addHome(
                                            name!,
                                            email!,
                                            newUser!,
                                            _panchayath!,
                                            wardno!,
                                            houseno!,
                                            owner!,
                                            house!,
                                            phone!);
                                        if (!mounted) return;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const HomeUserHome()));
                                      }
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title:
                                                  const Text("Error occured"),
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
                              child: const Text('Register'),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: const Text.rich(
                          TextSpan(text: 'Already have an account ', children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Color(0xffEE7B23)),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

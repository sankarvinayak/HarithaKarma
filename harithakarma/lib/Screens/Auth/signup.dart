import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Adminuser/Dashbord.dart';
import 'package:harithakarma/Screens/Auth/resetpassword.dart';
import 'package:harithakarma/Shared/custom_wigdets/InputBox.dart';
import 'package:harithakarma/Shared/custom_wigdets/PasswordBox.dart';
import 'package:harithakarma/Shared/panchayat_dropDown.dart';
import 'package:harithakarma/models/user.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:harithakarma/Screens/Fielduser/Dashbord.dart';
import 'package:harithakarma/Shared/loading.dart';
import 'package:harithakarma/service/database.dart';
import '../Homeuser/Dashbord.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  final AuthService _auth = AuthService();
  String? phone;
  String? house;
  String? email;
  String? password;
  String? name;
  String? insti;
  bool isLoading = false;
  var _dropDownValue;
  var _Panchayath = null;
  String? empid;
  String? wardno;
  String? houseno;
  String? owner;
  var newUser = null;
  bool validEmail = false;
  bool validPassword = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isLoading
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
                          const Text(
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
                          child: _dropDownValue == null
                              ? const Text('User')
                              : Text(
                                  _dropDownValue,
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
                              _dropDownValue = val;
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
                    _dropDownValue == "Admin"
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
                                    _Panchayath = val;
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
                        : _dropDownValue == "Field"
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
                                        Panchayat: (val) {
                                          setState(() {
                                            _Panchayath = val;
                                          });
                                        },
                                      )
                                      // child: StreamBuilder<QuerySnapshot>(
                                      //   stream:
                                      //       DatabaseService().getpanchayath(),
                                      //   builder: (BuildContext context,
                                      //       AsyncSnapshot<QuerySnapshot>
                                      //           snapshot) {
                                      //     if (!snapshot.hasData)
                                      //       return Container();

                                      //     return DropdownButton(
                                      //       hint: Container(
                                      //         alignment: Alignment.center,
                                      //         child: _Panchayath == null
                                      //             ? const Text(
                                      //                 'Panchayath/Muncipality/Corperation name')
                                      //             : Text(
                                      //                 _Panchayath,
                                      //               ),
                                      //       ),
                                      //       isExpanded: true,
                                      //       value: _Panchayath,
                                      //       items: snapshot.data!.docs
                                      //           .map((value) {
                                      //         return DropdownMenuItem(
                                      //           value: value.get('panchayath'),
                                      //           child: Text(
                                      //               '${value.get('panchayath')}'),
                                      //         );
                                      //       }).toList(),
                                      //       onChanged: (value) {
                                      //         setState(
                                      //           () {
                                      //             _Panchayath = value;
                                      //           },
                                      //         );
                                      //       },
                                      //     );
                                      //   },
                                      // )
                                      ),
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
                                        Panchayat: (val) {
                                          setState(() {
                                            _Panchayath = val;
                                          });
                                        },
                                      )
                                      // child: StreamBuilder<QuerySnapshot>(
                                      //   stream:
                                      //       DatabaseService().getpanchayath(),
                                      //   builder: (BuildContext context,
                                      //       AsyncSnapshot<QuerySnapshot>
                                      //           snapshot) {
                                      //     if (!snapshot.hasData)
                                      //       return Container();

                                      //     return DropdownButton(
                                      //       hint: Container(
                                      //         alignment: Alignment.center,
                                      //         child: _Panchayath == null
                                      //             ? const Text(
                                      //                 'Panchayath/Muncipality/Corperation name')
                                      //             : Text(
                                      //                 _Panchayath,
                                      //               ),
                                      //       ),
                                      //       isExpanded: true,
                                      //       value: _Panchayath,
                                      //       items: snapshot.data!.docs
                                      //           .map((value) {
                                      //         return DropdownMenuItem(
                                      //           value: value.get('panchayath'),
                                      //           child: Text(
                                      //               '${value.get('panchayath')}'),
                                      //         );
                                      //       }).toList(),
                                      //       onChanged: (value) {
                                      //         setState(
                                      //           () {
                                      //             _Panchayath = value;
                                      //           },
                                      //         );
                                      //       },
                                      //     );
                                      //   },
                                      // )
                                      ),
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
                              print(_Panchayath);
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                newUser = await _auth.signUpEmail(
                                    email!, password!, name!, _dropDownValue);

                                if (newUser != null) {
                                  // DatabaseService()
                                  //     .saveUser(newUser, _dropDownValue);
                                  if (_dropDownValue == 'Admin') {
                                    setadmin(newUser, name, email, _Panchayath,
                                        phone, empid);
                                    DatabaseService().addAdmin(name!, email!,
                                        newUser, empid!, _Panchayath, phone!);

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SideDrawerAdminHome()));
                                  } else if (_dropDownValue == 'Field') {
                                    setfield(newUser, name, email, _Panchayath,
                                        phone, empid);
                                    DatabaseService().addField(name!, email!,
                                        newUser, empid!, _Panchayath, phone!);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SideDrawerField()));
                                  } else {
                                    sethome(newUser, name, email, _Panchayath,
                                        phone, wardno, houseno, house, owner);
                                    DatabaseService().addHome(
                                        name!,
                                        email!,
                                        newUser,
                                        _Panchayath,
                                        wardno!,
                                        houseno!,
                                        owner!,
                                        house!,
                                        phone!);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SideDrawerHome()));
                                  }
                                }
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
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
                          const TextSpan(
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
          );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/Screens/Adminuser/Dashbord.dart';
import 'package:harithakarma/models/user.dart';
import 'package:harithakarma/service/auth.dart';
import 'package:harithakarma/Screens/Fielduser/Dashbord.dart';
import 'package:harithakarma/Shared/loading.dart';
import 'package:harithakarma/database.dart';
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
  String error = '';
  String? insti;
  bool isLoading = false;
  var _dropDownValue;
  var _Panchayath = null;
  String? empid;
  String? wardno;
  String? houseno;
  String? owner;

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
                    TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name ',
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border:
                            Border.all(style: BorderStyle.solid, width: 0.50),
                      ),
                      child: DropdownButton(
                        hint: Container(
                          alignment: Alignment.center,
                          child: _dropDownValue == null
                              ? Text('User')
                              : Text(
                                  _dropDownValue,
                                ),
                        ),
                        isExpanded: true,
                        iconSize: 40.0,
                        style: TextStyle(color: Colors.black, fontSize: 17.0),
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
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        suffixIcon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    _dropDownValue == "Admin"
                        ? (Column(
                            children: <Widget>[
                              TextField(
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  empid = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Employee id',
                                  suffixIcon: Icon(Icons.document_scanner),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextField(
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  _Panchayath = value;
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      'Panchayath/Muncipality/Corperation name',
                                  suffixIcon: Icon(Icons.location_city),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              )
                            ],
                          ))
                        : _dropDownValue == "Field"
                            ? (Column(
                                children: <Widget>[
                                  TextField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      empid = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Employee id',
                                      suffixIcon: Icon(Icons.document_scanner),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                      height: 60,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            width: 0.50),
                                      ),
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream:
                                            DatabaseService().getpanchayath(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (!snapshot.hasData)
                                            return Container();

                                          return DropdownButton(
                                            hint: Container(
                                              alignment: Alignment.center,
                                              child: _Panchayath == null
                                                  ? Text(
                                                      'Panchayath/Muncipality/Corperation name')
                                                  : Text(
                                                      _Panchayath,
                                                    ),
                                            ),
                                            isExpanded: true,
                                            value: _Panchayath,
                                            items: snapshot.data!.docs
                                                .map((value) {
                                              return DropdownMenuItem(
                                                value: value.get('panchayath'),
                                                child: Text(
                                                    '${value.get('panchayath')}'),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  _Panchayath = value;
                                                },
                                              );
                                            },
                                          );
                                        },
                                      )),
                                ],
                              ))
                            : (Column(
                                children: [
                                  Container(
                                      height: 60,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            width: 0.50),
                                      ),
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream:
                                            DatabaseService().getpanchayath(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (!snapshot.hasData)
                                            return Container();

                                          return DropdownButton(
                                            hint: Container(
                                              alignment: Alignment.center,
                                              child: _Panchayath == null
                                                  ? Text(
                                                      'Panchayath/Muncipality/Corperation name')
                                                  : Text(
                                                      _Panchayath,
                                                    ),
                                            ),
                                            isExpanded: true,
                                            value: _Panchayath,
                                            items: snapshot.data!.docs
                                                .map((value) {
                                              return DropdownMenuItem(
                                                value: value.get('panchayath'),
                                                child: Text(
                                                    '${value.get('panchayath')}'),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  _Panchayath = value;
                                                },
                                              );
                                            },
                                          );
                                        },
                                      )),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      wardno = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Ward number',
                                      suffixIcon: Icon(Icons.location_city),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      houseno = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'House no',
                                      suffixIcon: Icon(Icons.house),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      house = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'House name',
                                      suffixIcon: Icon(Icons.house),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      owner = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'House Owner name',
                                      suffixIcon:
                                          Icon(Icons.person_outline_rounded),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  )
                                ],
                              )),
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
                                isLoading = true;
                              });
                              final newUser = await _auth.signUpEmail(
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
                              } else {
                                setState(() {
                                  isLoading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              }
                            },
                            child: Text('Register'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                          color: Color.fromARGB(255, 218, 25, 11),
                          fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
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

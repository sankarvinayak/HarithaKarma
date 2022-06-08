import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(home: Myapp()));
}

class Myapp extends StatefulWidget {
  @override
  Login createState() => Login();
}

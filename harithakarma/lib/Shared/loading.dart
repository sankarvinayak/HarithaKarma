import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: SpinKitSpinningLines(
          color: Color.fromARGB(255, 69, 187, 23),
          size: 100.0,
        ),
      ),
    );
  }
}

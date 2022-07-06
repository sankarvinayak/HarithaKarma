import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: const Center(
        child: SpinKitSpinningLines(
          color: Color.fromARGB(255, 69, 187, 23),
          size: 100.0,
        ),
      ),
    );
  }
}

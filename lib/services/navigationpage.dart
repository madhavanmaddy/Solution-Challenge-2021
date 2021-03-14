import 'package:flutter/material.dart';
import 'package:smart_bus/screens/profile.dart';
import 'package:smart_bus/screens/qrscanner.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Qrscanner(),
          Profile(),
        ],
      ),
    );
  }
}

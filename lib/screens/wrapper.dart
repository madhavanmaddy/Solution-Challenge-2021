import 'package:flutter/material.dart';
import 'package:smart_bus/screens/authentication/authenticate.dart';
import 'package:smart_bus/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate
    return Authenticate();
  }
}

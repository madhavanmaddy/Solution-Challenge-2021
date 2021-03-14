import 'package:flutter/material.dart';
import 'package:smart_bus/services/SteamBuild.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('PROFILE',
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 30.0, color: Colors.white)),
        centerTitle: true,
      ),
      body: StreamBuild(),
    );
  }
}

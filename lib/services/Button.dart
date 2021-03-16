import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_bus/screens/qrscanner.dart';
import 'package:smart_bus/services/SteamBuild.dart';
import 'package:smart_bus/services/firestore.dart';

import 'authservice.dart';

class ButtonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RaisedButton(
              onPressed: () async {
                topup();
              },
              splashColor: Color(0xFF7A9BEE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(10),
                ),
              ),
              color: Colors.black,
              child: Container(
                height: 60,
                width: 100,
                child: Center(
                  child: Text('TOP UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                print("Sign Out");
                AuthService().signOut();
              },
              splashColor: Color(0xFF7A9BEE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(35),
                ),
              ),
              color: Colors.black,
              child: Container(
                height: 60,
                width: 138,
                child: Center(
                  child: Text('SIGN OUT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var bal;
topup() async {
  QuerySnapshot plan = await FirebaseFirestore.instance
      .collection("Users")
      .where("Mobile", isEqualTo: getphone())
      .get();
  bal = plan.docs[0]["Balance"];
  var id = plan.docs[0].id;
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(id)
      .update({"Balance": bal + cardamount});
}

completeTrip() async {
  try {
    QuerySnapshot plan = await FirebaseFirestore.instance
        .collection("Users")
        .where("Mobile", isEqualTo: getphone())
        .get();
    bal = plan.docs[0]["Balance"];
    var id = plan.docs[0].id;
    if (bal < fare) {
      Fluttertoast.showToast(msg: "Not Enough Balance for the Trip");
    } else {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .update({"Balance": bal - fare});
      Fluttertoast.showToast(msg: "Fare has been debited from your Wallet");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Please Try Again');
  }
}

import 'package:flutter/material.dart';
import 'package:smart_bus/services/authservice.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Qrscanner extends StatefulWidget {
  @override
  _QrscannerState createState() => _QrscannerState();
}

class _QrscannerState extends State<Qrscanner> {
  String qrCodeResult;
  String source;
  String dest;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(143, 148, 251, 1),
        Color.fromRGBO(143, 148, 251, .6),
      ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('SCANNER',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    color: Colors.white)),
            centerTitle: true,
          ),
          body: ListView(children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height - 80.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent),
                Positioned(
                    top: 20.0,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45.0),
                              topRight: Radius.circular(45.0),
                            ),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height - 90.0,
                        width: MediaQuery.of(context).size.width)),
                Center(
                  child: Column(children: <Widget>[
                    SizedBox(height: 100),
                    tripcard(),
                    SizedBox(height: 20),
                    GestureDetector(
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                              child: Text(
                            "Scan QR Code",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () async {
                          ScanResult codeScanner =
                              // ignore: await_only_futures
                              await BarcodeScanner.scan(); //barcode scnner
                          if (codeScanner != null) {
                            setState(() {
                              if (source == null) {
                                source = codeScanner.rawContent;
                              } else {
                                dest = codeScanner.rawContent;
                              }
                            });
                          }
                        }),
                    SizedBox(height: 20),
                    GestureDetector(
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                              child: Text(
                            "Sign Out",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        onTap: () {
                          AuthService().signOut();
                        })
                  ]),
                ),
              ],
            ),
          ])),
    );
  }

  Widget tripcard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 250,
          height: 300,
          alignment: Alignment.center,
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Trip card',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Started from',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                source == null ? 'Please Scan At the Starting Point' : source,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'To',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                dest == null ? 'Please Scan At the dropping Point' : dest,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Fare : 50',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}

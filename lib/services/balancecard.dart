import 'package:flutter/material.dart';
import 'package:smart_bus/services/SteamBuild.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: 130.0,
      width: double.maxFinite,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
            color: Colors.black.withOpacity(1),
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 0.75),
          ),
          child: StreamBuilder(
              stream: getdetails(),
              builder: (context, snapshot) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text("  Balance",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent.withOpacity(0.8),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 230, bottom: 15),
                        child: Text("₹${snapshot.data.docs[0]['Balance']}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 35.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ]);
              })),
    );
  }
}

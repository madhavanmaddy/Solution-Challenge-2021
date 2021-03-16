import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_bus/services/firestore.dart';

import 'Button.dart';
import 'balancecard.dart';

var selectedCard = "Plan 1";
int cardamount = 50;

class StreamBuild extends StatefulWidget {
  @override
  _StreamBuildState createState() => _StreamBuildState();
}

class _StreamBuildState extends State<StreamBuild> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getdetails(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          }
          if (snapshot.data.size == 0) {
            return Center(
              child: Text("No data found",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 30.0,
                      color: Colors.white)),
            );
          }
          if (snapshot.hasData == true) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.size,
                itemBuilder: (context, index) {
                  return Stack(children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent),
                    Positioned(
                        top: 90.0,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45.0),
                                  topRight: Radius.circular(45.0),
                                ),
                                color: Colors.white),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width)),
                    Center(
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.jpg"),
                        radius: 60,
                      ),
                    ),
                    Positioned(
                        top: 130.0,
                        left: 25.0,
                        right: 25.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(snapshot.data.docs[0]['Name'],
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20.0),
                            Container(
                              child: Text(snapshot.data.docs[0]['Mobile'],
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20.0,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: 10.0),
                            BalanceCard(),
                            SizedBox(width: 10.0),
                            Container(
                                height: 40.0,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                )),
                            StreamBuilder(
                                stream: getplans(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Container(
                                      height: 100,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.size,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10.0),
                                                _buildInfoCard(
                                                    '${snapshot.data.docs[index]['Name']}',
                                                    snapshot.data.docs[index]
                                                        ['Amount']),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            ButtonCard(),
                          ],
                        ))
                  ]);
                });
          }
          return Container();
        });
  }

  Widget _buildInfoCard(String cardTitle, int rate) {
    selectCard(cardTitle) {
      setState(() {
        selectedCard = cardTitle;
        cardamount = rate;
      });
    }

    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("$rate/-",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 25.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ])));
  }
}

getdetails() {
  String searchphone = getphone();
  return FirebaseFirestore.instance
      .collection('Users')
      .where("Mobile", isEqualTo: searchphone)
      .snapshots();
}

getplans() {
  return FirebaseFirestore.instance
      .collection("Plans")
      .orderBy("Name")
      .snapshots();
}

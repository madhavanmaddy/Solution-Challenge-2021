import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> userSetup(String name, String mobile) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  users.add({'Name': name, 'Mobile': mobile});
  return;
}

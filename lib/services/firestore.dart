import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Users');
Future<void> userSetup(String name, String mobile) async {
  users.add({'Name': name, 'Mobile': mobile});
  return;
}

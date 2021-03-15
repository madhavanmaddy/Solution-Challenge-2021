import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Users');
Future<void> userSetup(String name, String mobile) async {
  var search = await users.where('Mobile', isEqualTo: mobile).get();
  if (search == null) {
    users.add({'Name': name, 'Mobile': mobile, 'Balance': 0});
  }

  return;
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

Future<String> getphone() async {
  final String phone = user.phoneNumber;
  return phone;
}

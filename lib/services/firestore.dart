import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Users');
Future<void> userSetup(String name, String mobile) async {
  var search = await FirebaseFirestore.instance
      .collection('Users')
      .where("Mobile", isEqualTo: mobile)
      .get();
  if (search.size == 0)
    users.add({'Name': name, 'Mobile': mobile, 'Balance': 0});
  return;
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

String getphone() {
  final String phone = user.phoneNumber;

  return phone;
}

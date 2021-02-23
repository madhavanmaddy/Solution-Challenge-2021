import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bus/screens/authentication/authenticate.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signin with phone
/*
  Future<bool> signinphone() async {
    _auth.verifyPhoneNumber(
        // phoneNumber: phone,
        timeout: null,
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: null,
        codeAutoRetrievalTimeout: null);
  }
*/
  //sign out

}

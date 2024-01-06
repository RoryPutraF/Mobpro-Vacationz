import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // SIGN UP METHOD
  Future<User?> signUpWithEmailAndPassword(String username, String email,
      String password, String confirmpassword) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some Error Occured");
    }
    return null;
  }

  // SIGN IN METHOD
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some Error Occured");
    }
    return null;
  }
}

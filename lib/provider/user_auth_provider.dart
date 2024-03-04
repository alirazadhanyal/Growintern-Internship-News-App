import 'package:bnews/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  void signIn(String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }

    notifyListeners();
  }

  void signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void signOut() {
    _auth.signOut();
    notifyListeners();
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  static FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  // UserModel _userFromFirebaseUser(FirebaseUser user) {
  //   return user != null ? UserModel(uid: user.uid) : null;
  // }

  // auth change user stream
  static Stream<FirebaseUser> get user => _auth.onAuthStateChanged;
  // sign in anon


  static Future<FirebaseUser> signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  static Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    } 
  }

  static Future<FirebaseUser> registerWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign out
  static Future<void> signOut() async {
    _auth.signOut();
  }

}
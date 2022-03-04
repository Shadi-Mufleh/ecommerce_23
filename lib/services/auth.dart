import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BaseAuth {
  Future<FirebaseFirestoreUser> googleSignIn();
}

class Auth implements BaseAuth {
  FirebaseFirestoreAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<FirebaseFirestoreUser> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
  }
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    try{
      FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}

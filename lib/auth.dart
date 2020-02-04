import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static bool newAccount = false;
  static bool useFb = false;
  static bool useGoogle = false;

  static Future<Void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount account = await googleSignIn.signIn();
    final GoogleSignInAuthentication auth = await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    final AuthResult authResult =
        await firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);
    assert(!user.isAnonymous);

    final idToken = await user.getIdToken();
    final token = idToken.token;

    useGoogle = true;
    useFb = false;
  }

  static void signOut() async {
    await googleSignIn.signOut();
  }
}

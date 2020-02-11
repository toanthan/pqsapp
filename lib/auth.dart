import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'common.dart';
import 'state/auth_state.dart';

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
    bool result = await mediaAuth(context, token);
    if (!result) {
      //
    }

    useGoogle = true;
    useFb = false;
  }

  static Future<bool> mediaAuth(BuildContext context, String token) async {
    var response = await http.post(API_HOST + '/auth/token', body: token);
    var userId = int.parse(response.body);
    if (userId > 0) {
      Provider.of<AuthState>(context, listen: false).updateAuth(userId);
    }
    return userId > 0;
  }

  static void signOut() async {
    await googleSignIn.signOut();
  }
}

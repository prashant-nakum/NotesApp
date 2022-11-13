import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:notesapp/pages/homepage.dart';

//creat an instance of googleSignIn
GoogleSignIn googleSignIn = GoogleSignIn();

//create instance of firebase authantication
final FirebaseAuth auth = FirebaseAuth.instance;

//create an instance of collection user
CollectionReference users = FirebaseFirestore.instance.collection('users');

//A Future can be completed in two ways: with a value or with an error.
//future means the work is asynchronous that is started and complete in future
Future<bool> signInWithGoogle(BuildContext context) async {
  try {

    //first we will get google sign in account
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    //if google sign in account is not null then do authentication means add that user in our database
    if (googleSignInAccount != null) {
      //do the authentication means get the google sign in account
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      //Access tokens are what the Auth client uses to make requests to an API. The access token is meant to be read and validated by the API.
      //An ID token contains information about what happened when a user authenticated, and is intended to be read by the Auth client.
      //credential is for authenticate the google user
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

       //once successful crendential then sign in user to firebase
      final UserCredential authResult =
          await auth.signInWithCredential(credential);

      //this will give the user which is authenticated
      final User user = authResult.user!;

      //for save the user data in our database we will do this
      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

      //if user exist then update the data inside database
      //if not exist then save the data inside database

      //first get the data from the database
      users.doc(user.uid).get().then((doc) {
        if (doc.exists) {
          //old user
          //update the userdata inside database
          doc.reference.update(userData);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );

        } else {
          //new user
          //add the userdata to database
          users.doc(user.uid).set(userData);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      });
    }
    return true;
  } catch (PlatformException) {
    print(PlatformException);
    print('Sign in not successful !');
    rethrow;
  }
}

//for sign out from the google account
Future<bool> signOutWithGoogle(BuildContext context) async {
  await auth.signOut();
  await googleSignIn.signOut();
  return true;
}

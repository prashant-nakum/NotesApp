// import 'dart:js';
/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notesapp/pages/SignUp.dart';
import 'package:notesapp/pages/addnote.dart';
import 'package:notesapp/pages/homepage.dart';
import 'package:notesapp/pages/login.dart';
import 'package:notesapp/pages/viewnote.dart';


void main() => runApp(MaterialApp(

    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/home': (context) => HomePage(),
      '/auth': (context) => SignUp(),
      '/addnote' : (context) => AddNote(),
      '/viewnote' : (context) => ViewNote(),
    }
));

*/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/controller/google_auth.dart';
import 'package:notesapp/pages/addnote.dart';
import 'package:notesapp/pages/homepage.dart';
import 'package:notesapp/pages/login.dart';

void main() async {
  // First we have to Initiliaze the firebase make async because this is asynchronous task
  WidgetsFlutterBinding.ensureInitialized();
//make sure firebase is initialize
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      //add the background color
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color(0xff070706), //black
      ),
      home: LoginPage(),
      //for hide the debug logo
      debugShowCheckedModeBanner: false,
      // home: AuthService().handleAuthState(),
    );
  }
}

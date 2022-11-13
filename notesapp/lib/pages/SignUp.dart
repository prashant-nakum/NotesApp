import 'package:flutter/material.dart';
import 'package:notesapp/pages/homepage.dart';
import 'package:notesapp/pages/login.dart';
import 'package:notesapp/reusable_widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //three controller for add three field
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //by default this is false, making true we can change the appbar height add appbar in stack
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),

        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  //pass the text, icontype , text is password or not and the controller
                  reusableTextField('Enter User Name', Icons.person_outline,
                      false, _userNameTextController),
                  SizedBox(
                    height: 20.0,
                  ),
                  reusableTextField('Enter Email Id', Icons.email_outlined,
                      false, _emailTextController),
                  SizedBox(
                    height: 20.0,
                  ),
                  reusableTextField('Enter Password', Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 100.0,
                  ),
                  loginSignInButton(context, false, () {
                    //this will create our firebase authentication add the user inside the database
                    //this will create a new user inside our database
                    //we will navigate only when the user and account is created
                    //create the user using the emailid and password
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      print("Created New Account");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  })
                ],
              )),
        ),
      ),
    );
  }
}

/*
1) click -> back then                    redirect : login page
2) click -> sign up then create new user redirect : login page
 */

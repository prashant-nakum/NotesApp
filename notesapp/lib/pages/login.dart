import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:notesapp/controller/google_auth.dart';
import 'package:notesapp/pages/SignUp.dart';
import 'package:notesapp/pages/homepage.dart';
import 'package:notesapp/reusable_widgets/reusable_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //this controller code is used at the reusable_widgets.dart //2
  //creating this controller we can enter the email and password inside text field
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //scalffold is a class(widget) which occupy the whole screen of device which provide many widget and api(floating action , navigation)
    return Scaffold(
      //container is like scaffold but in scaffold the location of any widget if fix(flo.ac.btn) in container we will do any design(flexible)
      //inside this we can add the margin padding, border, child
      body: Container(
        //MediaQuery provides a higher-level view of the current app's screen size and can also give more detailed information about the device and its layout preferences.
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //it describes how a box should be painted on the screen. The shape of the box needs not to be just a rectangle or a square it can circle also.
        decoration: BoxDecoration(
          color: Colors.black,
        ),

        // SingleChildScrollView : A box in which a single widget can be scrolled
        //This widget is useful when you have a single box that will normally be entirely visible,
        // for example a clock face in a time picker, but you need to make sure it can be scrolled if the container gets too small in one axis (the scroll direction).
        //like if card count is increase then we scroll down
        child: SingleChildScrollView(
          //add the empty space around the widget
          child: Padding(
            //here top padding is as per the size of the screen
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                //this function is give data from the reusable_widgets.dart //1
                //set the image properly
                logoWidget('assets/images/img4.webp'),

                SizedBox(
                  height: 30.0,
                ),

                //this controller code is from the reusable_widgets.dart //2
                //this will give the style to the email address field from thr reusable_widgets.dart
                //pass the text, icontype , text is password or not and the controller
                reusableTextField('Enter Email', Icons.email_outlined, false,
                    _emailTextController),

                SizedBox(
                  height: 20.0,
                ),

                //this controller code is from the reusable_widgets.dart //2
                //password field
                reusableTextField('Enter Password', Icons.lock_outline, true,
                    _passwordTextController),

                SizedBox(
                  height: 20.0,
                ),

                //this function is design in reusable_widgets.dart //3
                loginSignInButton(context, true, () {
                  //this function is when the user click on the login button then what to do
                  //check inside the firebase if this user are there and if user exist the go to the home page
                  //if user is exist then go to the home page else error
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }).onError((error, stackTrace) {
                    print('Error ${error.toString()}');
                  });
                }),

                //for sign up if user is new , function is at the bottom of the code
                signUpOption(),

                SizedBox(
                  height: 20.0,
                ),

                //for sign in with google
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 12.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      //this would imlemented in controller/google_auth.dart, pass the context
                      signInWithGoogle(context);
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          "Continue With Google",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "lato",
                          ),
                        ),

                        SizedBox(
                          width: 10.0,
                        ),

                        Image.asset(
                          'assets/images/img2.png',
                          height: 36.0,
                        ),

                      ],
                    ),

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                      ),
                    ),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white70),
        ),
        //Gesture Detector in Flutter is used to detect the user's gestures on the application. It is a non-visual widget.
        // Inside the gesture detector, another widget is placed and the gesture detector will capture all these events (gestures) and execute the tasks accordingly.
        //when user click on the sign up text then the the gesture detector gestuer and take the action
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
          child: const Text(
            '  Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Future createUser({required String name}) async {
    //Reference to document
  }
}

/*
1)click -> login : if user exist then     redirect : homepage
1)click -> sign up : for create new user  redirect : sign up page
1)click -> login with google :  then      redirect : homepage
 */
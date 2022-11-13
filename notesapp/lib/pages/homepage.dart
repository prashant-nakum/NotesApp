import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/pages/addnote.dart';
import 'package:notesapp/pages/login.dart';
import 'package:notesapp/controller/google_auth.dart';
import 'package:notesapp/pages/viewnote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //take the data reference from the user collection -> notes collection
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  //this is the list of the color for the color of the card and the color is randomly selected
  /*List<Color> myColors = [
    Colors.yellowAccent,
    Colors.red,
    Colors.green,
    Colors.deepPurple,
    Colors.cyan,
    Colors.teal,
    Colors.tealAccent,
    Colors.pink,
  ];*/

  //for getting search bar functionality
  String title = '';

 //create the text editing controller for add the text in search bar
  TextEditingController _searchTextController = TextEditingController();

  //creating custom icon
  Icon cusIcon = Icon(Icons.search);

  //when we not click on the the search button then this search bar was displayed
  Widget cusSearchBar = Text(
    'Notes',
    style: TextStyle(
      fontSize: 32.0,
      fontFamily: 'Aboreto',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading meanse what is the leading(first) thing on app bar
        //here leading is icon for logout
        leading: Padding(
          padding: const EdgeInsets.only(left: 7.0),
          child: new IconButton(
            icon: new Icon(Icons.logout_outlined, color: Colors.white),
            onPressed: () {
              //when user click on the signout button the that is signout and go back to the login page
              signOutWithGoogle(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              //  }
              // );
            },
          ),
        ),

        //use this action for add more thing inside the app bar
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //when we pressed on search button then search bar was open
                //and when click on the cancle button then invisible the search bar
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      controller: _searchTextController,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Text',
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      onChanged: (_val) {
                        setState(() {
                          title = _val;
                        });
                      },
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text(
                      'NOTES',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: 'Aboreto',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }
                });
              },
              icon: cusIcon),
          SizedBox(
            width: 10.0,
          ),
        ],
        title: cusSearchBar,
        elevation: 0.0,
        backgroundColor: Colors.black87,
      ),

      //this future builder  with QuerySnapshot is for fetching the data from the database
      //FutureBuilder Widget is used to create widgets based on the latest snapshot of interaction with a Future.
      //It is necessary for Future to be obtained earlier either through a change of state or change in dependencies.
      body: FutureBuilder<QuerySnapshot>(
        //get the reference of that user data from the database
        future: ref.get(),
        //create the builder pass the context and snapshot
        builder: (context, snapshot) {
          //snapshot : A Snapshot simplifies accessing and converting properties in a JSON-like object, for example a JSON object returned from a REST-api service.
          if (snapshot.hasData) {
            //if there is no any note created then display this
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Let's Start!",
                      style: TextStyle(
                        // backgroundColor: Colors.white,
                        color: Colors.cyan,
                        fontFamily: 'lato',
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              );
            }
           //if any note is avaliable then
            //list view is used to create the list of children
            //when we want to create a list recursively without writing code again and again then ListView.builder is used instead of ListView
            //ListView. builder creates a scrollable, linear array of widgets
            return ListView.builder(
              //count how many iteam(note) are created by user
                itemCount: snapshot.data?.docs.length,
                //build that item
                itemBuilder: (context, index) {
                  //generate any random number
                 // Random random = new Random();
                  //select background color of that card as per as random number
                 /* Color bg = myColors[random.nextInt(7)];*/
                  //inside map store the perticular note data
                  Map data = snapshot.data?.docs[index].data() as Map;
                  //get the time and date when the note is created
                  DateTime mydateTime = data['created'].toDate();
                  //foramt the date time
                  String formmatedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                  //first search bar(here title) is null then dispaly the all the note
                  //when user enter any in search bar then the filter the note
                  if (data['description'].toString().contains(title) ||
                      data['title'].toString().contains(title)) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 1.0),
                      //inkwell is widget that respond the click event that have rectangular area
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                              //MaterialPageRoute : A modal route that replaces the entire screen with a platform-adaptive transition
                            MaterialPageRoute(
                              //when click on note then display the note with all the user data
                              builder: (context) => ViewNote(
                                data,
                                formmatedTime,
                                snapshot.data!.docs[index].reference,
                              ),
                            ),
                          )
                              .then((value) {
                            setState(() {});
                          });
                        },
                        //inside the card widget we have to provide which thing i have to display on home page card(inkwell card)
                        //here we add time and title
                        child: Card(
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data['title']}',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formmatedTime,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            //when sign in then at loading time add this spin kit
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 90.0,
              ),
            );

            /*  Center(
                          child: Text('Loading...'),
                        );*/
          }
        },
      ),

      //floating action button for create the new note
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print("'Calling set State");
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),

      //for adding floating action button at left
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}


/*
1) click -> card   then the    redirect : viewnote.dart
2) click -> logout             redirect : login.dart
3) click -> add                redirect : addnote.dart
 */
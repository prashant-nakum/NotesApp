import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/controller/google_auth.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //here first take empty title and description
  String? title;
  String? des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //going back to home page
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(1.0, 1.0, 10.0, 1.0),
              //to create the note
              child: IconButton(
                onPressed: add,
                icon: const Icon(Icons.save_outlined),
                iconSize: 30.0,
              ),
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.black87,
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                //Flutter provides a Form widget to create a form. The form widget acts as a container, which allows us to group and validate the multiple form fields.
                //When you create a form, it is necessary to provide the GlobalKey.
                //This key uniquely identifies the form and allows you to do any validation in the form fields
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration.collapsed(hintText: 'Title'),
                      style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      onChanged: (_val) {
                        title = _val;
                      },
                    ),
                    //
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'Discription'),
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'lato',
                            color: Colors.grey),
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    //save the note to database
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');
//first we get the reference(instance) of collection note using current user id

    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };
//add that data inside database
    ref.add(data);

//and go back to the home page
    Navigator.pop(context);
  }
}


/*
1)click -> back   redirect -> homepage.dart
2)click -> save   redirect -> homepage.dart
 */
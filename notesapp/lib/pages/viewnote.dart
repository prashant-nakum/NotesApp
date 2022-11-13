import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';

class ViewNote extends StatefulWidget {

  final Map data;
  final String time;
  final DocumentReference ref;

  //here we will get the time and data from the home page.dart(ln. 198)
  ViewNote(this.data, this.time, this.ref);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String? title;
  String? des;

  // for edting a note  first keep false- 1
  bool edit = false;

  //when we create the form i have to provide this key for uniquely identify the form and do the validation
  GlobalKey<FormState> key = GlobalKey();

  TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //for edit the note
    //het title and description
    title = widget.data['title'];
    des = widget.data['description'];

    return SafeArea(
      child: Scaffold(
        //when click on edit then visible
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                child: Icon(
                  Icons.save_rounded,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              )
            : null,

        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 1.0, 1.0, 1.0),
            child: new IconButton(
              icon:
                  new Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: share,
              icon: const Icon(Icons.share),
            ),
            SizedBox(
              width: 5.0,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  // when click on this then the edit is enable or disable
                  edit = !edit;
                });
              },
              icon: const Icon(Icons.edit),
            ),
            SizedBox(
              width: 5.0,
            ),

            IconButton(
              onPressed: delete,
              icon: const Icon(Icons.delete),
            ),

            SizedBox(
              width: 10.0,
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
                  height: 10.0,
                ),
                SizedBox(
                  height: 18.0,
                ),
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      TextFormField(
                        //This is for edit the note
                        initialValue: widget.data['title'],
                        enabled: edit,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Title'),
                        style: TextStyle(
                            fontSize: 32.0,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        onChanged: (val) {
                          title = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                        ),
                        child: Text(
                          widget.time,
                          style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),

                      //
                      //for edit the note
                      TextFormField(
                        initialValue: widget.data['description'],
                        enabled: edit,
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
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    //deiete from database
    await widget.ref.delete();
    Navigator.pop(context);
  }

  //showing any kind of alert that new changes have been saved
  void save() async {
    if (key.currentState!.validate()) {
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }

  //function for share the note
  void share() async {
    await Share.share('Title: ' +
        widget.data['title'] +
        '\n' +
        '\n' +
        'Created time: ' +
        widget.time +
        '\n' +
        '\n' +
        'Description: ' +
        widget.data['description']);
  }
}

/*
1)click -> back                redirect : homepage.dart
2)click -> edit enable editing
3)click -> share enable sharing
4)click -> delete              redirect : homepage.dart
 */

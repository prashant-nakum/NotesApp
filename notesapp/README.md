# NotesApp

## About:
A note taking app made for making your daily task more efficient.

## 👋 Introduce
This is a note taking app made with **[Flutter](https://flutter.dev/)** that helps you to take notes of important things on your phone anytime. 

## Features
- Email & Password authentication
- Google authentication
- Creating a note
- Delete note
- Edit note
- Share note
- Save note
- Sign out 

## Description:

<ul>
<li> CRUD Operations of the app was performed by building an Firebase database. </li>
<li> Clean Architecture was implements by dividing the app into sub-components:
<ul>

<li> model <ul>
<li> controller </li>
<li> pages </li>
<li> reusable_widgets </li>
</ul>
</li>

<li> pages <ul>
<li>login</li>
<li> SignUp </li>
<li> homepage </li>
<li> addnote </li>
<li> viewnote </li>
</ul>
</li>

<li> firebase_database <ul>
<li> db </li>
</ul>
</li>

<li> widgets <ul>
<li>main</li>
</ul>
</li>

</ul> 
</li></li>
</ul>
Comments in the code, helps for better understanding of how the app works.


### To Run the App:
In the command terminal, run the following commands:

    $ flutter pub get
    $ flutter run

## Tech used
**Server** : Firebase
**Client** : Flutter


## ℹ️ Version and packages used
- Flutter 3.0.5 
- Dart 2.17.6
- CupertinoIcons class for iOS style icons : [cupertino_icons: ^1.0.2][cupertino_icons]
- For storing data : [firebase: ^9.0.3][firebase]
- For firebase authentication : [firebase_auth: ^3.11.0][firebase_auth]
- For firebase core : [firebase_core: ^1.24.0][firebase_core]
- For firebase data base : [cloud_firestore: ^3.5.0][cloud_firestore]
- For google sign in : [google_sign_in: ^5.4.2][google_sign_in]
- For formatting date and time : [intl: ^0.17.0][intl]
- For adding spin at loading time : [flutter_spinkit: ^5.1.0][flutter_spinkit]
- For share text and file : [share_plus: ^4.4.0][share_plus]
- For sharing file : [flutter_share: ^2.0.0][flutter_share]

## Packages
<!-- Packages -->
[cupertino_icons] : https://pub.dev/packages/cupertino_icons
[firebase] : https://pub.dev/packages/firebase
[firebase_auth] : https://pub.dev/packages/firebase_auth
[firebase_core] : https://pub.dev/packages/firebase_core
[cloud_firestore] : https://pub.dev/packages/cloud_firestore
[google_sign_in] : https://pub.dev/packages/google_sign_in
[intl] : https://pub.dev/packages/intl
[flutter_spinkit] : https://pub.dev/packages/flutter_spinkit
[share_plus] : https://pub.dev/packages/share_plus
[flutter_share] : https://pub.dev/packages/flutter_share


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../Screens/OrganizerDashboard/organizer_dashboard.dart';
import '../main_scaffold.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  String? get userId => _user?.uid;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String address,
    String countryCode,
    File? profileImage,
    String? orgName,
    String? panNumber,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String? imageUrl;

      if (profileImage != null) {
        final fileName = path.basename(profileImage.path);
        final storageRef =
            FirebaseStorage.instance.ref().child('profile_images/$fileName');
        final uploadTask = storageRef.putFile(profileImage);

        await uploadTask.whenComplete(() async {
          imageUrl = await storageRef.getDownloadURL();
        });
      }

      await FirebaseFirestore.instance
          .collection('attendees')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'countryCode': countryCode,
        'profileImage': imageUrl,
      });

      print('/////Success/////');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> registerAsOrganizer(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String address,
    String countryCode,
    File? profileImage,
    String? orgName,
    String? panNumber,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String? imageUrl;

      if (profileImage != null) {
        final fileName = path.basename(profileImage.path);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images_organizer/$fileName');
        final uploadTask = storageRef.putFile(profileImage);

        await uploadTask.whenComplete(() async {
          imageUrl = await storageRef.getDownloadURL();
        });
      }

      await FirebaseFirestore.instance
          .collection('organizers')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'countryCode': countryCode,
        'profileImage': imageUrl,
        'organizationName': orgName,
        'panNumber': panNumber,
      });

      print('/////Success/////');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginAsOrganizer(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      String userId = userCredential.user!.uid;

      DocumentSnapshot organizerDoc = await FirebaseFirestore.instance
          .collection('organizers')
          .doc(userId)
          .get();

      if (organizerDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        print('User not found in the organizers collection');
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No User Found On that Email');
      } else if (e.code == 'wrong-password') {
        print('Wrong Password');
      }
    }
  }

  Future<void> logIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      String userId = userCredential.user!.uid;

      DocumentSnapshot attendeeDoc = await FirebaseFirestore.instance
          .collection('attendees')
          .doc(userId)
          .get();

      DocumentSnapshot organizerDoc = await FirebaseFirestore.instance
          .collection('organizers')
          .doc(userId)
          .get();

      if (attendeeDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainScaffold(
                    selectedIndex: 0,
                  )),
        );
      } else if (organizerDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        print('User not found in any collection');
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No User Found On that Email');
      } else if (e.code == 'wrong-password') {
        print('Wrong Password');
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScaffold(selectedIndex: 0)),
      );
      notifyListeners();
    } catch (e) {
      print('Logout failed: $e');
    }
  }
}

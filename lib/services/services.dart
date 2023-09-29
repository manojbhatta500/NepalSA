import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      SnackBar message = SnackBar(content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(message);
      print('error $e');
      return null;
    }
  }

  Future<User?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        print('user credential was null so returning is null');
        return null;
      }
    } catch (e) {
      SnackBar message = SnackBar(
        content: Text('$e'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(message);

      print('something went wrong here ');
      return null;
    }
  }

  Future<User?> getcurrentuser() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser;
    } else {
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    print('signing out user');
    SnackBar message = SnackBar(
      content: Text('Logged out completed.'),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(message);
    _auth.signOut();
    Navigator.pushNamed(context, '/');
    print('signed out completed');
  }

  void senddata(String gotid, String gotmessage) {
    firestore.collection('messages').add({
      'id': gotid,
      'Message': gotmessage,
      "timestamp": FieldValue.serverTimestamp()
    });
  }
}

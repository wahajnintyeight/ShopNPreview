import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_n_preview/models/retailer.dart';
import 'package:shop_n_preview/services/dbFuture.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class retailerAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Retailer curRetailer = Retailer();
  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      curRetailer = await DBFuture().getRetailInfo(authResult.user.uid);
      if (curRetailer != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      print("WORKS");
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName, String Uname) async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      Retailer _user = Retailer(
          rID: _authResult.user.uid,
          email: _authResult.user.email,
          fName: fullName.trim(),
          accCreated: Timestamp.now(),
          Uname: Uname.toString());
      String _returnString = await DBFuture().createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}

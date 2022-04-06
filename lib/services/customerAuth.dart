import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_n_preview/models/customer.dart';
import 'package:shop_n_preview/services/dbFuture.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class customerAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Customer curCustomer = Customer();

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      curCustomer = await DBFuture().getCustomerInfo(authResult.user.uid);
      if (curCustomer != null) {
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


  Future<Customer> returnCustomerID(String email, String password) async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      curCustomer = await DBFuture().getCustomerInfo(authResult.user.uid);
      if (curCustomer != null) {
       retVal = authResult.user.uid;
      }
    } on PlatformException catch (e) {

      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return curCustomer;
  }

  Future<String> signOut() async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpCustomer(String email, String password, String fullName,
      String Uname, String PhoneNUM) async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      Customer _user = Customer(
        cID: _authResult.user.uid,
        uName: Uname.toString(),
        phoneNum: PhoneNUM,
        fName: fullName.trim(),
        accCreated: Timestamp.now(),
      );
      String _returnString = await DBFuture().createCustomer(_user);
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

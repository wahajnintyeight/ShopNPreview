import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_n_preview/models/retailer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/earrings.dart';
import '../models/customer.dart';

class DBFuture {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _earringsRef = FirebaseFirestore.instance.collection('earrings');

  //SIGN UP RETAILER
  Future<String> createUser(Retailer user) async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      await _firestore.collection("retailer").doc(user.rID).set({
        'fullName': user.fName.trim(),
        'email': user.email.trim(),
        'accountCreated': Timestamp.now(),
        'userName': user.Uname
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> createCustomer(Customer user) async {
    String retVal = "error";
    Firebase.initializeApp();
    try {
      await _firestore.collection("customer").doc(user.cID).set({
        'fullName': user.fName.trim(),
        'phoneNum': user.phoneNum,
        'registeredOn': Timestamp.now(),
        'userName': user.uName
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> addEarrings(Earrings earrings) async {
    String retVal = "error";
    Firebase.initializeApp();

    try {
      await _firestore.collection("earrings").doc(earrings.eID).set({
        'name': earrings.name.trim(),
        'price': earrings.price,
        'outOfStock': earrings.outOfStock,
        'createdOn': Timestamp.now(),
        'type': earrings.type,
        'thumbnail': earrings.thumbnail
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<List> returnEarrings() async {
    Firebase.initializeApp();

    QuerySnapshot querySnapshot = await _earringsRef.get();
    final List loadedResult = [];
    // Get data from docs and convert map to List
    // List allData = querySnapshot.documents.map((doc) => doc.data).toList();
    for(var earring in querySnapshot.docs){
      loadedResult.add(earring);
    }
    // List allData = querySnapshot.docs.map((doc) => doc.data).toList();
    // querySnapshot.docs.forEach(
            // (element) => loadedResult.add(.fromJson(element.data)));
    print(loadedResult);
    print('wwwwwwwwwwwwwwwwwwww');
    // print(allData[0]);
    return loadedResult;
  }





  Future<List> returnEarringsID() async {
    QuerySnapshot querySnapshot = await _earringsRef.get();

    // Get data from docs and convert map to List
    List allData =
        querySnapshot.docs.map((doc) => doc.id).toList();
    return allData;
  }

  Future<Customer> getCustomerInfo(String cID) async {
    Firebase.initializeApp();
    Customer retVal = Customer();
    try {
      final _docSnapshot = FirebaseFirestore.instance;
      await _docSnapshot.collection("customer").doc(cID).get().then((DocumentSnapshot documentSnapshot) {
        retVal.cID = cID;
        retVal.fName = documentSnapshot.get("fullName");
        retVal.uName = documentSnapshot.get("userName");
        retVal.phoneNum = documentSnapshot.get("phoneNum");
        retVal.accCreated = documentSnapshot.get("accountCreated");
      });
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<Retailer> getRetailInfo(String rID) async {
    Retailer retVal = Retailer();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("retailer").doc(rID).get();
      retVal.rID = rID;
      retVal.fName = (_docSnapshot.data as dynamic)['fullName'];
      retVal.email = (_docSnapshot.data as dynamic)["email"];
      retVal.accCreated = (_docSnapshot.data as dynamic)["accountCreated"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}

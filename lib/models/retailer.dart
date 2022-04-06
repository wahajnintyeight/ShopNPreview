import 'package:cloud_firestore/cloud_firestore.dart';

class Retailer {
  String fName;
  String rID;
  String email;
  Timestamp accCreated;
  String Uname;
  Retailer({
    this.rID,
    this.email,
    this.fName,
    this.accCreated,
    this.Uname
  });

}
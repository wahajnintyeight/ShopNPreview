import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String fName;
  String cID;
  Timestamp accCreated;
  String uName;
  String phoneNum;
  Customer({this.cID, this.fName, this.phoneNum, this.accCreated, this.uName});
}

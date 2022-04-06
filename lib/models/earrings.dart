import 'package:cloud_firestore/cloud_firestore.dart';

class Earrings {
  String name;
  String eID;
  bool outOfStock;
  String thumbnail;
  String type;
  int price;
  Timestamp createdOn;
  Earrings({
    this.eID,
    this.name,
    this.outOfStock,
    this.thumbnail,
    this.type,
    this.price,
    this.createdOn,
  }
  );
}

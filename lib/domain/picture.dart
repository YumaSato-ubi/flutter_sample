import 'package:cloud_firestore/cloud_firestore.dart';

class Picture {
  Picture(QueryDocumentSnapshot doc) {
    documentID = doc.id;
    name = doc['name'];
    imageURL = doc['imageURL'];
  }

  String documentID;
  String name;
  String imageURL;
}

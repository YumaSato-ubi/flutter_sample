import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  Book(QueryDocumentSnapshot doc) {
    documentID = doc.id;
    title = doc['full_name'];
    subtitle = doc['last_name'];
    imageURL = doc['imageURL'];
  }

  String documentID;
  String title;
  String subtitle;
  String imageURL;
}

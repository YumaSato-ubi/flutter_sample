import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddBookModel extends ChangeNotifier {
  String userFullName = '';
  String userLastName = '';

  Future addBookToFirebase() async {
    if (userFullName.isEmpty) {
      throw ('full_nameを入力してください');
    }
    if (userLastName.isEmpty) {
      throw ('last_nameを入力してください');
    }
    FirebaseFirestore.instance.collection('users').add(
      {'full_name': userFullName, 'last_name': userLastName},
    );
  }
}

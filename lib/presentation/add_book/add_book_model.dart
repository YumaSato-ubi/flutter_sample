import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/domain/book.dart';

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

  Future updateBook(Book book) {
    final document =
        FirebaseFirestore.instance.collection('users').doc(book.documentID);
    document.update(
      {
        'full_name': userFullName,
        'last_name': userLastName,
        'updateAt': Timestamp.now()
      },
    );
  }
}

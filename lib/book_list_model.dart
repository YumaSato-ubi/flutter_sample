import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final data = await FirebaseFirestore.instance.collection('users').get();
    final books = data.docs.map((doc) => Book(doc['full_name'])).toList();
    this.books = books;
    notifyListeners();
  }
}

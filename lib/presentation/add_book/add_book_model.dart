import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String userFullName = '';
  String userLastName = '';
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedfile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedfile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    final imageURL = await _uploadImage();

    if (userFullName.isEmpty) {
      throw ('full_nameを入力してください');
    }
    if (userLastName.isEmpty) {
      throw ('last_nameを入力してください');
    }
    FirebaseFirestore.instance.collection('users').add(
      {
        'full_name': userFullName,
        'last_name': userLastName,
        'imageURL': imageURL,
      },
    );
  }

  Future updateBook(Book book) async {
    final imageURL = await _uploadImage();

    final document =
        FirebaseFirestore.instance.collection('users').doc(book.documentID);
    document.update(
      {
        'full_name': userFullName,
        'last_name': userLastName,
        'imageURL': imageURL,
        'updateAt': Timestamp.now()
      },
    );
  }

  Future<String> _uploadImage() async {
    // TODO: strageへのアップロード
    final storage = FirebaseStorage.instance;
    TaskSnapshot snapshot =
        await storage.ref('books/$userFullName').putFile(imageFile);
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}

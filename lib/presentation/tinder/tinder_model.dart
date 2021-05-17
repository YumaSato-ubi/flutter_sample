import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sample/domain/book.dart';

class TinderModel extends ChangeNotifier {
  num index;

  List<String> welcomeImages = [];

  Future loadStorage() async {
    // TODO: Storageから画像を取得
    final storage = FirebaseStorage.instance;
    ListResult result = await storage.ref().listAll();
    return result;
  }

  Future<void> listExample() async {
    final storage = FirebaseStorage.instance;
    ListResult result = await FirebaseStorage.instance.ref('books/').listAll();

    result.items.forEach((Reference ref) {
      storage.ref(ref.fullPath).getDownloadURL().then((v) {
        welcomeImages.add(v);
      });
    });
    notifyListeners();
  }
}

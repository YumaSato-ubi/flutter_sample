import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/domain/book.dart';
import 'package:sample/domain/picture.dart';

class AddPictureModel extends ChangeNotifier {
  String pictureName = '';
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

  Future addPictureToFirebase() async {
    final imageURL = await _uploadImage();

    if (pictureName.isEmpty) {
      throw ('画像の名前を入力してください');
    }

    FirebaseFirestore.instance.collection('pictures').add(
      {
        'picture_name': pictureName,
        'imageURL': imageURL,
      },
    );
  }

  Future updatePicture(Picture picture) async {
    final imageURL = await _uploadImage();

    final document = FirebaseFirestore.instance
        .collection('pictures')
        .doc(picture.documentID);
    document.update(
      {
        'picture_name': pictureName,
        'imageURL': imageURL,
        'updateAt': Timestamp.now()
      },
    );
  }

  Future<String> _uploadImage() async {
    // TODO: strageへのアップロード
    final storage = FirebaseStorage.instance;
    TaskSnapshot snapshot =
        await storage.ref('pictures/$pictureName').putFile(imageFile);
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}

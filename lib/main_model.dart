import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String kboytext = 'not change';

  void changeKboyText(){
    kboytext = 'changed';
    notifyListeners();
  }
}
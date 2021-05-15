import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/firestore_sample.dart';
import 'package:sample/main_model.dart';
import 'package:sample/next_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      model.kboytext,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    ElevatedButton(
                      child: Text("ボタン"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GetUserName('r13MEUVyWpwxa8Ow5oSl')),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/main_model.dart';
import 'package:sample/next_page.dart';

void main() {
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
                        onPressed:(){
                          model.changeKboyText();
                        },
                        child: Text('ボタン'),
                    )
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

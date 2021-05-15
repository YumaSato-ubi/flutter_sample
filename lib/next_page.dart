import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  NextPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('次の画面'),
        ),
        body: Container(
          color: Colors.red,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              Center(
                child: ElevatedButton(
                  child: Text('戻る'),
                    onPressed: () {
                      Navigator.pop(context, 'yes');
                    }
                ),
              ),
            ],
          ),
        )
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(document['last_name']),
                    subtitle: Text(document['full_name']),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
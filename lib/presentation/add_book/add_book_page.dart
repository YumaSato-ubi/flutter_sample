import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/domain/book.dart';

import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = book != null;
    final textEditingController = TextEditingController();
    final subtextEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = book.title;
      subtextEditingController.text = book.subtitle;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(isUpdate ? 'レスラーを編集' : 'レスラーを追加'),
            ),
            body: Consumer<AddBookModel>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 160,
                        child: InkWell(
                          onTap: () async {
                            // TODO: カメラロールを開く
                            model.showImagePicker();
                          },
                          child: model.imageFile != null
                              ? Image.file(model.imageFile)
                              : Container(color: Colors.grey),
                        ),
                      ),
                      TextField(
                        controller: textEditingController,
                        onChanged: (text) {
                          model.userFullName = text;
                        },
                      ),
                      TextField(
                        controller: subtextEditingController,
                        onChanged: (text) {
                          model.userLastName = text;
                        },
                      ),
                      ElevatedButton(
                        child: Text(isUpdate ? '更新する' : '追加する'),
                        onPressed: () async {
                          model.startLoading();
                          if (isUpdate) {
                            await updateBook(model, context);
                          } else {
                            await addBook(model, context);
                          }
                          model.endLoading();
                          // todo: 追加する
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Consumer<AddBookModel>(builder: (context, model, child) {
            return model.isLoading
                ? Container(
                    color: Colors.grey.withOpacity(0.7),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox();
          })
        ],
      ),
    );
  }

  Future addBook(AddBookModel model, BuildContext context) async {
    try {
      await model.addBookToFirebase();
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました！'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future updateBook(AddBookModel model, BuildContext context) async {
    try {
      await model.updateBook(book);
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新しました！'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

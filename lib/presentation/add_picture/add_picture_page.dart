import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/domain/picture.dart';

import 'add_picture_model.dart';

class AddPicturePage extends StatelessWidget {
  AddPicturePage({this.picture});
  final Picture picture;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = picture != null;
    final textEditingController = TextEditingController();
    final subtextEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = picture.name;
    }

    return ChangeNotifierProvider<AddPictureModel>(
      create: (_) => AddPictureModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(isUpdate ? '写真を編集' : '写真を追加'),
            ),
            body: Consumer<AddPictureModel>(
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
                          model.pictureName = text;
                        },
                      ),
                      ElevatedButton(
                        child: Text(isUpdate ? '更新する' : '追加する'),
                        onPressed: () async {
                          model.startLoading();
                          if (isUpdate) {
                            await updatePicture(model, context);
                          } else {
                            await addPicture(model, context);
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
          Consumer<AddPictureModel>(builder: (context, model, child) {
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

  Future addPicture(AddPictureModel model, BuildContext context) async {
    try {
      await model.addPictureToFirebase();
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
      // Navigator.of(context).pop();
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

  Future updatePicture(AddPictureModel model, BuildContext context) async {
    try {
      await model.updatePicture(picture);
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
      // Navigator.of(context).pop();
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

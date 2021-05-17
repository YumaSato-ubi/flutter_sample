import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';
import 'package:sample/domain/book.dart';
import 'package:sample/presentation/add_book/add_book_page.dart';
import 'package:sample/presentation/tinder/tinder_model.dart';

class TinderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CardController controller;
    final Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<TinderModel>(
      create: (_) => TinderModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tinder'),
        ),
        body: Consumer<TinderModel>(
          builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: new TinderSwapCard(
                      swipeUp: true,
                      swipeDown: true,
                      orientation: AmassOrientation.BOTTOM,
                      totalNum: model.welcomeImages.length,
                      stackNum: 3,
                      swipeEdge: 1.0,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.width * 0.9,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      minHeight: MediaQuery.of(context).size.width * 0.8,
                      cardBuilder: (context, index) => Card(
                        child: Image.network('${model.welcomeImages[index]}'),
                      ),
                      cardController: controller = CardController(),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        /// Get swiping card's alignment
                        if (align.x < 0) {
                          //Card is LEFT swiping
                          print('No');
                          print(size.width);
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                          print('Yes');
                        }
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) {
                        /// Get orientation & index of swiped card!
                        model.index = index;
                        print('${model.welcomeImages[index]}');
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        model.listExample();
                      },
                      child: Text('storage'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

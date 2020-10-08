import 'package:flutter/material.dart';

class User {
  String name;
  int score;
  int items = 3;
  List<Image> itemsList = new List();

  User({
    this.name,
    this.score,
  });

  ListView drawTabu() {
    if (itemsList.isEmpty) {
      for (int i = 0; i < this.items; i++) {
        itemsList.add(Image.asset(
          'assets/images/item.png',
          width: 50.0,
          height: 50.0,
        ));
      }
    }
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          return itemsList[index];
        });
  }
}

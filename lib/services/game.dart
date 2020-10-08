import 'package:flutter/material.dart';

class Game extends ChangeNotifier {
  int users;
  int rounds;

  Game({this.users, this.rounds});
}

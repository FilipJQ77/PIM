import 'package:flutter/cupertino.dart';

class Player {
  String name;
  Color color;
  int points = 0;
  bool active = false;

  Player(this.name, this.color);

  void addPoints(int points) {
    this.points += points;
  }
}

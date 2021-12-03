import 'package:flutter/cupertino.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

class Player {
  String name;
  Color color = AppColors.purple;
  int points = 0;
  bool active = false;
  List<HandLetter> letters = [];

  Player(this.name, this.letters);

  void addPoints(int points) {
    this.points += points;
  }
}

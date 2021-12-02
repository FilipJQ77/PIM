import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

class GameHand extends StatelessWidget {
  final List<HandLetter> playerLetters;

  const GameHand({
    Key? key,
    required this.playerLetters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: playerLetters,
      ),
    );
  }
}

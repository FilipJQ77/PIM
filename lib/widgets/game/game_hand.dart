import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
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
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: AppColors.mistyWhite,
              child: Row(
                children: playerLetters,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/player_info.dart';
import 'package:pim_word_builder/widgets/timer.dart';

// todo chyba stateful pozniej? idk tbh
class GameInfo extends StatelessWidget {
  const GameInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        PlayerInfo(playerName: "Player 1", points: 69),
        Timer(),
        PlayerInfo(playerName: "Player 2", points: 69),
      ],
    );
  }
}
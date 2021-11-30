import 'package:flutter/material.dart';
import 'package:pim_word_builder/player.dart';
import 'package:pim_word_builder/widgets/game/player_info.dart';
import 'package:pim_word_builder/widgets/game/timer.dart';

class GameInfo extends StatelessWidget {
  final List<Player> players;
  final Function endTurnFunction;

  const GameInfo(
      {Key? key, required this.players, required this.endTurnFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayerInfo(player: players[0]), // todo better in the future
          Timer(endTurnFunction: endTurnFunction),
          PlayerInfo(player: players[1]),
        ],
      ),
    );
  }
}

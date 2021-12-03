import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/player.dart';
import 'package:pim_word_builder/widgets/game/player_info.dart';
import 'package:pim_word_builder/widgets/game/timer.dart';

class GameInfo extends StatelessWidget {
  final List<Player> players;
  final Function endTurn;

  const GameInfo(
      {Key? key, required this.players, required this.endTurn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PlayerInfo(player: players[0]), // todo better in the future
          Timer(endTurnFunction: endTurn),
          PlayerInfo(player: players[1]),
        ],
      ),
    );
  }
}

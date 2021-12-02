import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/game/game_button.dart';

class GameButtonRow extends StatelessWidget {
  final Function undoFunction;
  final Function exchangeFunction;
  final Function shuffleFunction;
  final Function endTurnFunction;

  const GameButtonRow({
    Key? key,
    required this.undoFunction,
    required this.exchangeFunction,
    required this.shuffleFunction,
    required this.endTurnFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          UndoButton(undoFunction: undoFunction),
          ExchangeButton(exchangeFunction: exchangeFunction),
          ShuffleButton(shuffleFunction: shuffleFunction),
          EndTurnButton(endTurnFunction: endTurnFunction)
        ],
      ),
    );
  }
}

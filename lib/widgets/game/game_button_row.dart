import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/game/game_button.dart';

class FunctionButtonRow extends StatelessWidget {
  final Function undoFunction;
  final Function exchangeFunction;
  final Function shuffleFunction;
  final Function endTurnFunction;

  const FunctionButtonRow({
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
        children: [
          UndoButton(function: undoFunction),
          ExchangeButton(function: exchangeFunction),
          ShuffleButton(function: shuffleFunction),
          EndTurnButton(function: endTurnFunction)
        ],
      ),
    );
  }
}

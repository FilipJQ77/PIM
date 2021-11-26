import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import 'package:pim_word_builder/widgets/game/game_button_row.dart';
import 'package:pim_word_builder/widgets/game/game_hand.dart';
import 'package:pim_word_builder/widgets/game/game_info.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  void undo() {
    print("Undo");
  }

  void exchange() {
    print("Exchange");
  }

  void shuffle() {
    print("Shuffle");
  }

  void endTurn() {
    print("End Turn");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColors.purple),
      home: Scaffold(
          appBar: const BabbleAppBar(),
          body: Column(
            children: <Widget>[
              const GameInfo(),
              Expanded(
                flex: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                          color: AppColors.mistyWhite,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            // child: Center(child: widget.board),
                          )),
                    ),
                  ],
                ),
              ),
              const GameHand(),
              FunctionButtonRow(
                  undoFunction: undo,
                  exchangeFunction: exchange,
                  shuffleFunction: shuffle,
                  endTurnFunction: endTurn),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import 'package:pim_word_builder/widgets/game_button_row.dart';
import 'package:pim_word_builder/widgets/game_info.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

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

              // TODO WYDZIELIĆ TO JAKO WIDGET RĘKI
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.mistyWhite,
                        child: Row(
                            // children: widget.handLetters,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              FunctionButtonRow(undoFunction: () {
                print("Undo");
              }, exchangeFunction: () {
                print("Exchange");
              }, shuffleFunction: () {
                print("Shuffle");
              }, endTurnFunction: () {
                print("End Turn");
              }),
            ],
          )),
    );
  }
}

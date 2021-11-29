import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/letter_bag.dart';
import 'package:pim_word_builder/player.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import 'package:pim_word_builder/widgets/game/board.dart';
import 'package:pim_word_builder/widgets/game/board_tile.dart';
import 'package:pim_word_builder/widgets/game/game_button_row.dart';
import 'package:pim_word_builder/widgets/game/game_hand.dart';
import 'package:pim_word_builder/widgets/game/game_info.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

const int numberOfPlayers = 2;
const int boardSize = 15;

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<Player> players;
  late LetterBag letterBag;
  late List<List<HandLetter>> playerLetters; // list of letters for every player
  late List<List<BoardTile>> boardTiles; // n x n list of tiles

  @override
  initState() {
    super.initState();

    players = [];
    letterBag = LetterBag();
    playerLetters = [];

    for (var i = 0; i < numberOfPlayers; i++) {
      players.add(Player("Player ${i + 1}", Colors.deepPurple));

      playerLetters.add([]);
      playerLetters[i].addAll(letterBag.drawHand().map((letter) => HandLetter(
            letter: letter,
          )));
    }

    boardTiles = [];
    for (var i = 0; i < boardSize; i++) {
      boardTiles.add([]);
      for (var j = 0; j < boardSize; j++) {
        boardTiles[i].add(BoardTile(x: i, y: j));
      }
    }
  }

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
              GameInfo(players: players),
              Board(boardTiles: boardTiles),
              GameHand(playerLetters: playerLetters[0]),
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

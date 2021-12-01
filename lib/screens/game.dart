import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/letter_bag.dart';
import 'package:pim_word_builder/pair.dart';
import 'package:pim_word_builder/player.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import 'package:pim_word_builder/widgets/game/board.dart';
import 'package:pim_word_builder/widgets/game/board_tile.dart';
import 'package:pim_word_builder/widgets/game/game_button_row.dart';
import 'package:pim_word_builder/widgets/game/game_hand.dart';
import 'package:pim_word_builder/widgets/game/game_info.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

const int numberOfPlayers = 2;
const int handSize = 7;
const int boardSize = 15;

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<Player> players;
  late List<List<HandLetter>> playerLetters; // list of letters for every player

  late List<HandLetter> currentLetters;
  HandLetter? currentLetter;
  late int currentPlayerIndex;

  late List<List<BoardTile>> boardTiles; // n x n list of tiles
  late LetterBag letterBag;

  late List<Pair<int, int>> playerMovesThisTurn;

  @override
  initState() {
    super.initState();

    players = [];
    letterBag = LetterBag();
    playerLetters = [];

    for (var i = 0; i < numberOfPlayers; i++) {
      players.add(Player("Player ${i + 1}", Colors.deepPurple));

      playerLetters.add([]);
      playerLetters[i].addAll(
          letterBag.getLettersFromBag(handSize).map((letter) => HandLetter(
                letter: letter,
                function: newCurrentLetter,
              )));
    }

    currentPlayerIndex = 0;
    currentLetters = playerLetters[currentPlayerIndex];

    playerMovesThisTurn = [];

    boardTiles = [];
    for (var i = 0; i < boardSize; i++) {
      boardTiles.add([]);
      for (var j = 0; j < boardSize; j++) {
        boardTiles[i].add(BoardTile(
            x: i,
            y: j,
            letter: "",
            isTaken: false,
            tileColor: BoardTile.getTileColor(i, j),
            function: placeLetterOnBoard));
      }
    }
  }

  void undo() {
    if (playerMovesThisTurn.isEmpty) return;
    var lastMove = playerMovesThisTurn.removeLast();
    var x = lastMove.a;
    var y = lastMove.b;
    var letter = boardTiles[x][y].letter;
    setState(() {
      boardTiles[x][y] = BoardTile(
          x: x,
          y: y,
          letter: "",
          isTaken: false,
          tileColor: BoardTile.getTileColor(x, y),
          function: placeLetterOnBoard);

      currentLetters
          .add(HandLetter(letter: letter, function: newCurrentLetter));
    });
  }

  void exchange() {
    // exchange one piece
    print("Exchange");

  }

  void shuffle() {
    // exchange whole hand
    if (currentLetters.length !=  handSize) {
        print("You can't shuffle. Remove your tiles from board!");
        return;
    }
    print("Shuffle");
    setState(() {
      List<HandLetter> tempLetters = playerLetters[currentPlayerIndex]; //remember current hand
      playerLetters[currentPlayerIndex].clear();  // clear current hand
      // draw new letters
      playerLetters[currentPlayerIndex].addAll(
          letterBag.getLettersFromBag(handSize).map((letter) => HandLetter(
            letter: letter,
            function: newCurrentLetter,
          )));
      // add old letters to the bag
      letterBag.addLettersToBag(
          tempLetters.map((handLetter) => handLetter.letter));
      currentLetters = playerLetters[currentPlayerIndex]; // switch current letters (new hand)
    });
    endTurn(); // end turn
  }

  void endTurn() {
    print("End Turn");
    setState(() {
      currentLetters.addAll(letterBag
          .getLettersFromBag(handSize - currentLetters.length)
          .map((letter) =>
              HandLetter(letter: letter, function: newCurrentLetter)));

      // players[currentPlayerIndex].points += 10; // this works already btw

      //todo improve
      currentPlayerIndex++;
      currentPlayerIndex %= numberOfPlayers;

      playerMovesThisTurn.clear();

      print(currentPlayerIndex);
      currentLetters = playerLetters[currentPlayerIndex];
    });
  }

  void placeLetterOnBoard(int x, int y) {
    if (currentLetter != null && !boardTiles[x][y].isTaken) {
      print("Placing ${currentLetter!.letter} on tile $x $y");
      setState(() {
        boardTiles[x][y] = BoardTile(
            x: x,
            y: y,
            letter: currentLetter!.letter,
            isTaken: true,
            tileColor: AppColors.cream,
            function: placeLetterOnBoard);

        print(boardTiles[x][y].letter);
        currentLetters.remove(currentLetter);

        playerMovesThisTurn.add(Pair(x, y));

        currentLetter = null;
      });
    }
  }

  void newCurrentLetter(HandLetter handLetter) {
    setState(() {
      currentLetter = handLetter;
      print("Current letter is now ${currentLetter!.letter}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColors.purple),
      home: Scaffold(
          appBar: const BabbleAppBar(),
          body: Column(
            children: <Widget>[
              GameInfo(players: players, endTurnFunction: endTurn),
              Board(boardTiles: boardTiles),
              GameHand(playerLetters: currentLetters),
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

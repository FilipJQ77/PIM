import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/classes/letter_bag.dart';
import 'package:pim_word_builder/classes/pair.dart';
import 'package:pim_word_builder/classes/player.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import 'package:pim_word_builder/widgets/game/board.dart';
import 'package:pim_word_builder/widgets/game/board_tile.dart';
import 'package:pim_word_builder/widgets/game/game_button_row.dart';
import 'package:pim_word_builder/widgets/game/game_hand.dart';
import 'package:pim_word_builder/widgets/game/game_info.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';
import 'package:pim_word_builder/widgets/game/game_popups.dart';

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
  late int currentPlayerIndex;

  late List<HandLetter> currentLetters;
  HandLetter? currentLetter;

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
                newCurrentLetter: newCurrentLetter,
                active: false,
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

      currentLetters.add(HandLetter(
        letter: letter,
        newCurrentLetter: newCurrentLetter,
        active: false,
      ));
    });
  }

  void exchangeChosenLetter() {
    if (currentLetter == null) {
      print("Exchange will not happen as no letter was selected");
      // todo 'error' popup
      return;
    }

    HandLetter chosenLetter = currentLetter!;

    setState(() {
      // get chosen letter
      currentLetters.remove(chosenLetter);

      // draw new letter
      currentLetters
          .addAll(letterBag.getLettersFromBag(1).map((letter) => HandLetter(
                letter: letter,
                newCurrentLetter: newCurrentLetter,
                active: false,
              )));

      // add old letter to the bag
      letterBag.addLettersToBag([chosenLetter.letter]);

      // after exchanging set current letter to null as it was exchanged
      currentLetter = null;
    });

    // end turn
    endTurn();
  }

  void exchange() {
    if (currentLetters.length != handSize) {
      print("You can't exchange. Remove your tiles from board!");
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => ExchangePopup(
          playerLetters: currentLetters,
          exchangeChosenLetter: exchangeChosenLetter),
    );
  }

  void shuffle() {
    // exchange whole hand
    if (currentLetters.length != handSize) {
      print("You can't shuffle. Remove your tiles from board!");
      // todo 'error' popup
      return;
    }

    setState(() {
      // remember current hand
      List<HandLetter> tempLetters = currentLetters;

      // clear current hand
      currentLetters.clear();

      // draw new letters
      currentLetters.addAll(
          letterBag.getLettersFromBag(handSize).map((letter) => HandLetter(
                letter: letter,
                newCurrentLetter: newCurrentLetter,
                active: false,
              )));

      // add old letters to the bag
      letterBag
          .addLettersToBag(tempLetters.map((handLetter) => handLetter.letter));
    });
    endTurn(); // end turn
  }

  void endTurn() {
    print("End Turn");
    setState(() {
      // refill player hand
      currentLetters.addAll(letterBag
          .getLettersFromBag(handSize - currentLetters.length)
          .map((letter) => HandLetter(
                letter: letter,
                newCurrentLetter: newCurrentLetter,
                active: false,
              )));
      clearActiveLetter();

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
      int handLetterIndex = currentLetters.indexOf(handLetter);

      clearActiveLetter();

      currentLetters[handLetterIndex] = HandLetter(
          letter: handLetter.letter,
          newCurrentLetter: newCurrentLetter,
          active: true);

      currentLetter = currentLetters[handLetterIndex];

      print("Current letter is now ${currentLetter!.letter}");
    });
  }

  void clearActiveLetter() {
    if (currentLetter != null) {
      int currentLetterIndex = currentLetters.indexOf(currentLetter!);
      currentLetters[currentLetterIndex] = HandLetter(
          letter: currentLetter!.letter,
          newCurrentLetter: newCurrentLetter,
          active: false);

      currentLetter = null;
    }
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
              GameButtonRow(
                  undoFunction: undo,
                  exchangeFunction: exchange,
                  shuffleFunction: shuffle,
                  endTurnFunction: endTurn),
            ],
          )),
    );
  }
}

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
  late int currentPlayerIndex;
  late Player currentPlayer;

  HandLetter? currentLetter;

  late List<List<BoardTile>> boardTiles; // n x n list of tiles
  late LetterBag letterBag;

  late List<Pair<int, int>> movesThisTurn;

  @override
  initState() {
    super.initState();

    players = [];
    letterBag = LetterBag();

    for (var i = 0; i < numberOfPlayers; i++) {
      List<HandLetter> newLetters = letterBag
          .getLettersFromBag(handSize)
          .map((letter) => HandLetter(
                letter: letter,
                newCurrentLetter: newCurrentLetter,
                active: false,
              ))
          .toList();

      players.add(Player("Player ${i + 1}", newLetters));
    }

    currentPlayerIndex = 0;
    currentPlayer = players[currentPlayerIndex];
    currentPlayer.toggleActive();

    movesThisTurn = [];

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
    if (movesThisTurn.isEmpty) return;
    var lastMove = movesThisTurn.removeLast();
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

      currentPlayer.letters.add(HandLetter(
        letter: letter,
        newCurrentLetter: newCurrentLetter,
        active: false,
      ));
    });
  }

  void exchangeChosenLetter() {
    HandLetter chosenLetter = currentLetter!;

    setState(() {
      // get chosen letter
      currentPlayer.letters.remove(chosenLetter);

      // draw new letter
      currentPlayer.letters
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

    // end turn without pop up
    endPlayerTurn();
  }

  void exchangePopup() {
    if (currentPlayer.letters.length != handSize) {
      print("You can't exchange if you've put a letter on the board.");
      // todo popup
      return;
    }
    if (currentLetter == null) {
      print("You must choose a letter to exchange first.");
      // todo popup
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => ExchangePopup(
          chosenLetter: currentLetter!,
          exchangeChosenLetter: exchangeChosenLetter),
    );
  }

  void shuffleHand() {
    // exchange whole hand
    if (currentPlayer.letters.length != handSize) {
      print("You can't shuffle. Remove your tiles from board!");
      // todo 'error' popup
      return;
    }

    setState(() {
      currentLetter = null;
      // remember current hand
      List<HandLetter> tempLetters = currentPlayer.letters;

      // clear current hand
      currentPlayer.letters.clear();

      // draw new letters
      currentPlayer.letters.addAll(
          letterBag.getLettersFromBag(handSize).map((letter) => HandLetter(
                letter: letter,
                newCurrentLetter: newCurrentLetter,
                active: false,
              )));

      // add old letters to the bag
      letterBag
          .addLettersToBag(tempLetters.map((handLetter) => handLetter.letter));
    });

    // end turn without pop up
    endPlayerTurn();
  }

  void shufflePopup() {
    if (currentPlayer.letters.length != handSize) {
      print("You can't shuffle if you've put a letter on the board.");
      // todo popup
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => ShufflePopup(shuffleHand: shuffleHand),
    );
  }

  /// Ends turn without a popup.
  void endPlayerTurn() {
    setState(() {
      currentLetter = null;
      // refill player hand
      currentPlayer.letters.addAll(letterBag
          .getLettersFromBag(handSize - currentPlayer.letters.length)
          .map((letter) => HandLetter(
                letter: letter,
                newCurrentLetter: newCurrentLetter,
                active: false,
              )));
      clearActiveLetter();

      players[currentPlayerIndex].addPoints(10); // this works already btw

      currentPlayer.toggleActive();

      currentPlayerIndex++;
      currentPlayerIndex %= numberOfPlayers;

      currentPlayer = players[currentPlayerIndex];

      currentPlayer.toggleActive();

      movesThisTurn.clear();
    });
  }

  /// Ends player turn with a question popup.
  void endTurnPopup() {

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          EndTurnPopup(endPlayerTurn: endPlayerTurn, pointsGained: 69), // todo currentPlayerPoints po mergu
    );

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
        currentPlayer.letters.remove(currentLetter);

        movesThisTurn.add(Pair(x, y));

        currentLetter = null;
      });
    }
  }

  void newCurrentLetter(HandLetter handLetter) {
    setState(() {
      int handLetterIndex = currentPlayer.letters.indexOf(handLetter);

      clearActiveLetter();

      currentPlayer.letters[handLetterIndex] = HandLetter(
          letter: handLetter.letter,
          newCurrentLetter: newCurrentLetter,
          active: true);

      currentLetter = currentPlayer.letters[handLetterIndex];

      print("Current letter is now ${currentLetter!.letter}");
    });
  }

  void clearActiveLetter() {
    if (currentLetter != null) {
      int currentLetterIndex = currentPlayer.letters.indexOf(currentLetter!);
      currentPlayer.letters[currentLetterIndex] = HandLetter(
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
              GameInfo(players: players, endTurn: endPlayerTurn),
              Board(boardTiles: boardTiles),
              GameHand(playerLetters: currentPlayer.letters),
              GameButtonRow(
                  undoFunction: undo,
                  exchangeFunction: exchangePopup,
                  shuffleFunction: shufflePopup,
                  endTurnFunction: endTurnPopup),
            ],
          )),
    );
  }
}

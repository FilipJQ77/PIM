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

/// Number of players.
const int numberOfPlayers = 2;

/// How many letters a player has.
const int handSize = 7;

/// Size of the n x n board. (n == [boardSize])
const int boardSize = 15;

/// Game screen.
class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

/// Game state.
class _GameState extends State<Game> {
  /// List of players.
  late List<Player> players;

  /// Helper variable counting which player's turn it is now.
  late int currentPlayerIndex;

  /// Current player.
  late Player currentPlayer;

  /// Currently chosen letter.
  HandLetter? currentLetter;

  /// [boardSize] x [boardSize] board of tiles.
  late List<List<BoardTile>> boardTiles;

  /// Letter bag.
  late LetterBag letterBag;

  /// List of coordinates of placed tiles this turn.
  late List<Pair<int, int>> movesThisTurn;

  /// True if the first word is being placed, false otherwise.
  late bool firstTurn;

  /// todo
  late List<String> allowedWords = ["zig"]; // todo list->set

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
            color: BoardTile.getTileColor(i, j),
            placeLetterOnBoard: placeLetterOnBoard));
      }
    }
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
            color: AppColors.cream,
            placeLetterOnBoard: placeLetterOnBoard);

        currentPlayer.letters.remove(currentLetter);

        movesThisTurn.add(Pair(x, y));

        currentLetter = null;
      });
    }
  }

  /// Checks if the turn is correct, and if so, sort the moves.
  bool checkCorrectTurnAndSort(List<Pair<int, int>> movesThisTurn) {
    int x = movesThisTurn.first.a;
    int y = movesThisTurn.first.b;

    // word is on 'Y' axis
    if (movesThisTurn.every((move) => move.a == x)) {
      movesThisTurn.sort((pair1, pair2) => pair1.b.compareTo(pair2.b));
      for (var i = movesThisTurn.first.b; i <= movesThisTurn.last.b; i++) {
        if (!boardTiles[x][i].isTaken) {
          return false;
        }
      }
    }
    // word is on 'X' axis
    else if (movesThisTurn.every((move) => move.b == y)) {
      movesThisTurn.sort((pair1, pair2) => pair1.a.compareTo(pair2.a));
      for (var i = movesThisTurn.first.a; i <= movesThisTurn.last.a; i++) {
        if (!boardTiles[i][y].isTaken) {
          return false;
        }
      }
    } else {
      return false;
    }
    return true;
  }

  /// Returns a list of words, where a word is represented by a list of tiles (their position)
  List<List<Pair<int, int>>> getAllCreatedWords(
      List<Pair<int, int>> movesThisTurn) {
    Set<Pair<int, int>> usedTiles = {};

    List<List<Pair<int, int>>> wordsTiles = [];

    for (var move in movesThisTurn) {
      if (usedTiles.contains(move)) {
        continue;
      }

      var moveX = move.a;
      var moveY = move.b;

      /// gets the word from the left of the tile
      var wordX = moveX;

      // goes as far to the left from the tile as it can
      while (wordX >= 0 && boardTiles[wordX][moveY].isTaken) {
        wordX--;
      }
      wordX++;

      // gets all tiles from the left to the right and 'uses' them
      List<Pair<int, int>> newPossibleWord = [];
      while (wordX < boardSize && boardTiles[wordX][moveY].isTaken) {
        var tile = Pair(wordX, moveY);
        usedTiles.add(tile);
        newPossibleWord.add(tile);
      }
      if (newPossibleWord.length > 1) {
        wordsTiles.add(newPossibleWord);
      }

      /// gets the word from the up of the tile
      var wordY = moveY;

      while (wordY >= 0 && boardTiles[moveX][wordY].isTaken) {
        wordY--;
      }
      wordY++;

      newPossibleWord.clear();
      while (wordY < boardSize && boardTiles[moveX][wordY].isTaken) {
        var tile = Pair(wordX, moveY);
        usedTiles.add(tile);
        newPossibleWord.add(tile);
      }
      if (newPossibleWord.length > 1) {
        wordsTiles.add(newPossibleWord);
      }
    }
    return wordsTiles;
  }

  /// Returns list of pairs <word, scoreForThisWord>
  List<Pair<String, int>> getWordsAndPoints(
      List<List<Pair<int, int>>> wordsTiles) {
    List<Pair<String, int>> createdWords = [];

    for (var word in wordsTiles) {
      StringBuffer wordBuffer = StringBuffer();
      wordBuffer
          .writeAll(word.map((pair) => boardTiles[pair.a][pair.b].letter));

      String wordString = wordBuffer.toString();
      if (!allowedWords.contains(wordString)) {
        throw Exception(
            "Cannot end turn not allowed word"); // todo albo zwroc puste
      }

      bool doubleWordBonus = false;
      bool tripleWordBonus = false;

      int wordScore = 0;

      for (var tile in word) {
        var letter = boardTiles[tile.a][tile.b].letter;
        var color = BoardTile.getTileColor(tile.a, tile.b);
        // get points of a letter
        int letterPoints = LetterBag.getLetterValue(letter);
        // check bonuses
        if (color == AppColors.gold) {
          doubleWordBonus = true;
        } else if (color == AppColors.pink) {
          doubleWordBonus = true;
        } else if (color == AppColors.red) {
          tripleWordBonus = true;
        } else if (color == AppColors.aqua) {
          letterPoints *= 2;
        } else if (color == AppColors.darkBlue) {
          letterPoints *= 3;
        }

        wordScore += letterPoints;
      }

      if (doubleWordBonus) wordScore *= 2;
      if (tripleWordBonus) wordScore *= 3;

      createdWords.add(Pair(wordString, wordScore));
    }

    return createdWords;
  }

  /// Sums points for all words that have been created
  int calculateTurnPoints(List<Pair<String, int>> words) {
    int score = 0;
    for (var i = 0; i < words.length; i++) {
      score += words[i].b;
    }
    if (movesThisTurn.length == handSize) {
      score += 50;
    }
    return score;
  }

  int parseTurn() {
    if (checkCorrectTurnAndSort(movesThisTurn)) {
      var words = getAllCreatedWords(movesThisTurn);
      if (words.isNotEmpty) {
        var wordsAndPoints = getWordsAndPoints(words);
        return calculateTurnPoints(wordsAndPoints);
      }
    }
    return -1;
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

  /// Removes last placed tile from the board and puts it back to player hand.
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
          color: BoardTile.getTileColor(x, y),
          placeLetterOnBoard: placeLetterOnBoard);

      currentPlayer.letters.add(HandLetter(
          letter: letter, newCurrentLetter: newCurrentLetter, active: false));
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
    endPlayerTurn(0);
  }

  void exchangePopup() {
    if (movesThisTurn.isNotEmpty) {
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
    if (movesThisTurn.isNotEmpty) {
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
    endPlayerTurn(0);
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
  void endPlayerTurn(int points) {
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

      players[currentPlayerIndex].addPoints(points); // this works already btw

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
    if (movesThisTurn.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              EndTurnPopup(endPlayerTurn: endPlayerTurn, pointsGained: 0));
    } else {
      var points = parseTurn();
      if (points >= 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) => EndTurnPopup(
                endPlayerTurn: endPlayerTurn, pointsGained: points));
      } else {
        //todo popup o niepoprawnej rundzie
        print("Not correct turn pls");
      }
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
              GameInfo(players: players, endPlayerTurn: endPlayerTurn),
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

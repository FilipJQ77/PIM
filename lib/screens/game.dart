import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/classes/letter_bag.dart';
import 'package:pim_word_builder/classes/pair.dart';
import 'package:pim_word_builder/classes/player.dart';
import 'package:pim_word_builder/classes/utils.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import 'package:pim_word_builder/widgets/game/board.dart';
import 'package:pim_word_builder/widgets/game/board_tile.dart';
import 'package:pim_word_builder/widgets/game/game_button_row.dart';
import 'package:pim_word_builder/widgets/game/game_hand.dart';
import 'package:pim_word_builder/widgets/game/game_info.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';
import 'package:pim_word_builder/widgets/game/game_popups.dart';

/// Max number of points - end game
const int maxNumberOfPoints = 50;

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
  late Set<String> allowedWords = {};

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
            color: BoardTile.getTileColor(i, j),
            placeLetterOnBoard: placeLetterOnBoard));
      }
    }
    // todo because of async bullshit this technically finishes
    //  after initState but I dont give a fuck anymore
    getAllowedWords("assets/data/wordsGB.txt");
  }

  void getAllowedWords(String path) async {
    var allWords = await rootBundle.loadString(path);
    allowedWords.addAll(allWords.split('\n').map((x) => x.trim()));

    print("Allowed words ${allowedWords.length}");
  }

  void placeLetterOnBoard(int x, int y) {
    if (currentLetter != null && !boardTiles[x][y].isTaken) {
      print("Placing ${currentLetter!.letter} on tile $x $y");
      setState(() {
        boardTiles[x][y] = BoardTile(
            x: x,
            y: y,
            letter: currentLetter!.letter,
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
    var notUsedTiles = <Pair<int, int>>[];

    notUsedTiles.addAll(movesThisTurn);

    List<List<Pair<int, int>>> wordsTiles = [];

    for (var move in movesThisTurn) {
      if (!notUsedTiles.contains(move)) {
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
        notUsedTiles.remove(tile);
        newPossibleWord.add(tile);
        wordX++;
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

      newPossibleWord = [];
      while (wordY < boardSize && boardTiles[moveX][wordY].isTaken) {
        var tile = Pair(moveX, wordY);
        notUsedTiles.remove(tile);
        newPossibleWord.add(tile);
        wordY++;
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
      String wordString = "";
      for (var pair in word) {
        wordString += boardTiles[pair.a][pair.b].letter;
      }
      wordString = wordString.toLowerCase();
      // Comment when debugging
      if (!allowedWords.contains(wordString)) {
        print(wordString);
        return [];
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
    if (words.isEmpty){
      return -1;
    }
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
      showDialog(
        context: context,
        builder: (BuildContext context) => const ErrorPopup(
            errorMessage: "You can't exchange if you've put a letter on the board."),
      );

      return;
    }

    if (currentLetter == null) {
      print("You must choose a letter to exchange first.");
      showDialog(
        context: context,
        builder: (BuildContext context) => const ErrorPopup(
            errorMessage: "You must choose a letter to exchange first."),
      );
      return;
    }

    if(!letterBag.canIDrawLetters(1)){
      print("You can't exchange. There are not enough letters in the bag!");
      showDialog(
        context: context,
        builder: (BuildContext context) => const ErrorPopup(
            errorMessage: "You can't exchange. There are not enough letters in the bag!"),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => ExchangePopup(
          chosenLetter: currentLetter!,
          exchangeChosenLetter: exchangeChosenLetter),
    );
  }

  /// Exchange whole hand, then end turn
  void shuffleHand() {
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
      showDialog(
        context: context,
        builder: (BuildContext context) => const ErrorPopup(
            errorMessage: "You can't shuffle if you've put a letter on the board."),
      );
      return;
    }

    if(!letterBag.canIDrawLetters(handSize)){
      print("You can't shuffle. There are not enough letters in the bag!");
      showDialog(
        context: context,
        builder: (BuildContext context) => const ErrorPopup(
            errorMessage: "You can't shuffle. There are not enough letters in the bag!"),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => ShufflePopup(shuffleHand: shuffleHand),
    );
  }

  /// Ends turn without a popup.
 bool endPlayerTurn(int points) {

    // add players points
    setState(() {
      players[currentPlayerIndex].addPoints(points);
    });

   // check 'end of game' condition
   if(!letterBag.canIDrawLetters(handSize - currentPlayer.letters.length) || (currentPlayer.points >= maxNumberOfPoints)){
     return false;
   }

    setState(() {
      clearActiveLetter();

      // refill player hand
      currentPlayer.letters.addAll(letterBag
          .getLettersFromBag(handSize - currentPlayer.letters.length)
          .map((letter) => HandLetter(
                letter: letter,
                newCurrentLetter: newCurrentLetter,
                active: false,
              )));
      clearActiveLetter();

       // this works already btw

      currentPlayer.toggleActive();

      currentPlayerIndex++;
      currentPlayerIndex %= numberOfPlayers;

      currentPlayer = players[currentPlayerIndex];

      currentPlayer.toggleActive();

      movesThisTurn.clear();
    });
    return true;
  }

  /// Ends player turn with a question popup.
  void endTurnPopup() {
    if (movesThisTurn.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              EndTurnPopup(endPlayerTurn: endPlayerTurn, pointsGained: 0, players: players));
    } else {
      var points = parseTurn();
      if (points >= 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) => EndTurnPopup(
                endPlayerTurn: endPlayerTurn, pointsGained: points, players: players));
      } else {
        print("The tiles were placed incorrectly or the words are not allowed.");
        showDialog(
          context: context,
          builder: (BuildContext context) => const ErrorPopup(
              errorMessage: "You did not place the tiles correctly or the words you created are not allowed."),
        );
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

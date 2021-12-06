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

  bool isCorrectTurn(List<Pair<int, int>> movesThisTurn) {
    int x = movesThisTurn.first.a;
    int y = movesThisTurn.first.b;

    // if the move is in one column or one row
    // and the center tile has been taken
    if (boardTiles[7][7].isTaken &&
        (movesThisTurn.every((move) => move.a == x) ||
            movesThisTurn.every((move) => move.b == y))) {
      print("Correct turn"); // todo
      return true;
    }
    return false;
  }

  /// Establish which letter should be first (based on placed letters)
  Pair<int, int> getFirstLetterCordsOfPlacedLetters(List<Pair<int, int>> movesThisTurn){
    Pair<int, int> firstLetterCords = Pair(0, 0);
    // word is on 'X' axis
    if(movesThisTurn[0].a == movesThisTurn[1].a){
      int closestYCord = 100;
      for(var i=0;i<movesThisTurn.length;i++){
        if(closestYCord > movesThisTurn[i].b) {
          closestYCord = movesThisTurn[i].b;
          firstLetterCords = movesThisTurn[i];
        }
      }
    } else {  // word is on 'Y' axis
      int closestXCord = 100;
      for(var i=0;i<movesThisTurn.length;i++){
        if(closestXCord > movesThisTurn[i].a) {
          closestXCord = movesThisTurn[i].a;
          firstLetterCords = movesThisTurn[i];
        }
      }
    }
    return firstLetterCords;
  }

  /// Establish which letter should be last (based on placed letters)
  Pair<int, int> getLastLetterCordsOfPlacedLetters(List<Pair<int, int>> movesThisTurn){
    Pair<int, int> lastLetterCords = Pair(0, 0);
    // word is on 'X' axis
    if(movesThisTurn[0].a == movesThisTurn[1].a){
      int furthestYCord = -1;
      for(var i=0;i<movesThisTurn.length;i++){
        if(furthestYCord < movesThisTurn[i].b) {
          furthestYCord = movesThisTurn[i].b;
          lastLetterCords = movesThisTurn[i];
        }
      }
    } else {  // word is on 'Y' axis
      int furthestXCord = -1;
      for(var i=0;i<movesThisTurn.length;i++){
        if(furthestXCord < movesThisTurn[i].a) {
          furthestXCord = movesThisTurn[i].a;
          lastLetterCords = movesThisTurn[i];
        }
      }
    }
    return lastLetterCords;
  }

  /// This will get all tiles coordinates between two given tiles coordinates
  List<Pair<int, int>> getAllLettersCordsBetweenTwoLettersCords(
      Pair<int, int> firstLetterCords, Pair<int, int> lastLetterCords){

    List<Pair<int, int>> allLettersCords = [];

    if(firstLetterCords.a == lastLetterCords.a){ // word is on 'X' axis
      int wordLength = lastLetterCords.b - firstLetterCords.b + 1;
      for(var i=0; i< wordLength; i++)
        {allLettersCords.add(Pair(firstLetterCords.a, firstLetterCords.b + i));}
    } else { // firstMove.b == lastMove.b, word is on 'Y' axis
      int wordLength = lastLetterCords.a - firstLetterCords.a + 1;
      for(var i=0; i< wordLength; i++)
        {allLettersCords.add(Pair(firstLetterCords.a + i, firstLetterCords.b));}
    }
    return allLettersCords;
  }

  /// get cords of all letters which main word is build of
  List<Pair<int, int>> getMainWordTilesCords(List<Pair<int, int>> movesThisTurn){
    // Words can be written in two orders: from up to bottom and from left to right

    Pair<int, int> firstMove =  Pair(0, 0);
    Pair<int, int> lastMove =  Pair(0, 0);

    if(movesThisTurn.length == 1){
      firstMove =  movesThisTurn[0];
      lastMove =  movesThisTurn[0];
    }else{
      firstMove =  getFirstLetterCordsOfPlacedLetters(movesThisTurn);
      lastMove =  getLastLetterCordsOfPlacedLetters(movesThisTurn);
    }

    print("First move: ${firstMove.a} ${firstMove.b}");
    print("Last move: ${lastMove.a} ${lastMove.b}");

    Pair<int, int> startOfWord = firstMove;
    Pair<int, int> endOfWord = lastMove;

    // TODO take into account 'end of board' cases !!!

    // sufix case
    if(boardTiles[firstMove.a - 1][firstMove.b].isTaken ||
       boardTiles[firstMove.a][firstMove.b - 1].isTaken){
      var i = 1;
      if(boardTiles[firstMove.a - 1][firstMove.b].isTaken){
        while(boardTiles[firstMove.a - i][firstMove.b].isTaken){
          startOfWord = Pair(firstMove.a - i, firstMove.b);
          i++;
        }
        return getAllLettersCordsBetweenTwoLettersCords(startOfWord, endOfWord);
      }
      if(boardTiles[firstMove.a][firstMove.b - 1].isTaken){
        while(boardTiles[firstMove.a][firstMove.b - i].isTaken){
          startOfWord = Pair(firstMove.a, firstMove.b - i);
          i++;
        }
        return getAllLettersCordsBetweenTwoLettersCords(startOfWord, endOfWord);
      }
    }

    // prefix case
    if(boardTiles[firstMove.a + 1][firstMove.b].isTaken ||
       boardTiles[firstMove.a][firstMove.b + 1].isTaken){
      var i = 1;
      if(boardTiles[firstMove.a + 1][firstMove.b].isTaken){
        while(boardTiles[firstMove.a + i][firstMove.b].isTaken){
          endOfWord = Pair(firstMove.a + i, firstMove.b);
          i++;
        }
        return getAllLettersCordsBetweenTwoLettersCords(startOfWord, endOfWord);
      }
      if(boardTiles[firstMove.a][firstMove.b + 1].isTaken){
        while(boardTiles[firstMove.a][firstMove.b + i].isTaken){
          endOfWord = Pair(firstMove.a, firstMove.b + i);
          i++;
        }
        return getAllLettersCordsBetweenTwoLettersCords(startOfWord, endOfWord);
      }
    }

    // standard (whole) word case
    return getAllLettersCordsBetweenTwoLettersCords(startOfWord, endOfWord);

  }

  /// Returns list of <word, scoreForThisWord>
  List<Pair<String, int>> createdWordsThisTurn(List<Pair<int, int>> movesThisTurn) {
    // TODO check additional words - for now only main word is verified
    // Only main word should have bonuses
    // Bonuses can be reused (for now - easier implementation)
    List<Pair<int, int>> mainWordTilesCords = getMainWordTilesCords(movesThisTurn);
    List <Pair<String, int>> createdWords = [];

    String mainWord = "";
    int mainWordScore = 0;
    bool doubleWordBonus = false;
    bool tripleWordBonus = false;

    for(var i=0; i<mainWordTilesCords.length; i++) {
      Pair<int, int> tileCords = mainWordTilesCords[i];
      BoardTile tile = boardTiles[tileCords.a][tileCords.b];
      Color tileColor = BoardTile.getTileColor(tileCords.a, tileCords.b);
      mainWord += tile.letter;

      // get value of a letter
      int letterValue = LetterBag.getLetterValue(tile.letter);
      // Check bonuses
      if(tileColor == AppColors.gold) {doubleWordBonus = true;}
      else if(tileColor == AppColors.pink) {doubleWordBonus = true;}
      else if(tileColor == AppColors.red) {tripleWordBonus = true;}
      else if(tileColor == AppColors.aqua) {letterValue *= 2;}
      else if(tileColor == AppColors.darkBlue) {letterValue *= 3;}
      //
      mainWordScore += letterValue;
    }

    if(doubleWordBonus) mainWordScore *= 2;
    if(tripleWordBonus) mainWordScore *= 3;

    print("Main word: ${mainWord}, main word score ${mainWordScore}");

    createdWords.add(Pair(mainWord, mainWordScore));
    return createdWords;
  }

  /// Sums points for all words that have been created
  int calculateTurnPoints(List<Pair<String, int>> words) {
    int score = 0;
    for(var i=0; i<words.length; i++) {
      score += words[i].b;
    }
    return score;
  }

  int parseTurn() {
    bool correct = isCorrectTurn(movesThisTurn);
    if (correct) {
      var words = createdWordsThisTurn(movesThisTurn);
      if (words.isNotEmpty) {
        return calculateTurnPoints(words);
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

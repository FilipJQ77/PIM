import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pim_word_builder/views/game_view.dart';
import 'dart:io' as io;
import '../app_colors.dart';

var _homeButtonStyle = ElevatedButton.styleFrom(
  primary: AppColors.purple,
  onPrimary: AppColors.white,
  shadowColor: AppColors.purple,
  elevation: 3,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
  minimumSize: const Size(100, 40),
);

ElevatedButton _genericHomeButton(String text, Function function) {
  return ElevatedButton(
    style: _homeButtonStyle,
    child: Text(text),
    onPressed: () {
      function();
    },
  );
}

ElevatedButton startGameButton(BuildContext context) {
  return _genericHomeButton('Start Game', () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameView()),
    );
  });
}

ElevatedButton rulesButton(BuildContext context) {
  return _genericHomeButton('Rules', () {
    showDialog(
      context: context,
      builder: (BuildContext context) => _rulesPopup(context),
    );
  });
}

ElevatedButton authorsButton(BuildContext context) {
  return _genericHomeButton('Authors', () {
    showDialog(
      context: context,
      builder: (BuildContext context) => _authorsPopup(context),
    );
  });
}

ElevatedButton exitButton() {
  return _genericHomeButton('Exit', () {
    if (io.Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (io.Platform.isIOS) {
      io.exit(0);
    }
  });
}

AlertDialog _rulesPopup(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'BabbleWords!\nRules',
      textAlign: TextAlign.center,
    ),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text("Description\n", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              "BabbleWords! is a word game in which two players score points by placing tiles, each bearing a single letter, onto a game board divided into a 15×15 grid of squares. The tiles must form words that, in crossword fashion, read `left to right` in rows or `downward` in columns, and be included in a standard dictionary or lexicon."),
          Text("\nGameplay\n", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              "1. The first player combines two or more of his or her letters to form a word and places it on the board to read either across or down with one letter on the center square."),
          Text("Diagonal words are not allowed.\n"),
          Text("2. Complete your turn by clicking End Turn Button.\n"),
          Text(
              "3. Play passes to the next player. The second player, and then each in turn, adds one or more letters to those already played to form new words. All letters played on a turn must be placed in one row across or down the board, to form at least one complete word. If, at the same time, they touch others letters in adjacent rows, those must also form complete words, crossword fashion, with all such letters. The player gets full credit for all words formed or modified on his or her turn."),
          Text("4. New words may be formed by:         "),
          Text(
              "  - Adding one or more letters to a word or letters already on the board."),
          Text(
              "  - Placing a word at right angles to a word already on the board. The new word must use one of the letters already on the board or must add a letter to it.   "),
          Text(
              "  - Placing a complete word parallel to a word already played so that adjacent letters also form complete words."),
          Text("\nBonuses\n", style: TextStyle(fontWeight: FontWeight.bold)),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Red Tiles: ",
                    style: TextStyle(color: AppColors.red)),
                TextSpan(
                  text: 'Word points counts triple   \n',
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Pink Tiles: ",
                    style: TextStyle(color: AppColors.pink)),
                TextSpan(
                  text: "Word points counts double, including star on center\n",
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Dark Blue Tiles: ",
                    style: TextStyle(color: AppColors.darkBlue)),
                TextSpan(
                  text: "Letter on tile counts triple\n",
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Light Blue Tiles: ",
                    style: TextStyle(color: AppColors.aqua)),
                TextSpan(
                  text: "Letter on tile counts double\n",
                ),
              ],
            ),
          ),
          Text("Each bonus can be used only once,    "),
          Text("The effect of two premium squares are multiplying."),
          Text("\nBINGO!",
              style: TextStyle(
                  color: AppColors.purple, fontWeight: FontWeight.bold)),
          Text(
              "If you play seven tiles on a turn, it's a Bingo. You score a premium of 50 points after totaling our score for the turn.")
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Okay, got it!\n Let's play!",
            style: TextStyle(color: AppColors.purple)),
      ),
    ],
  );
}

AlertDialog _authorsPopup(BuildContext context) {
  return AlertDialog(
    title: const Text('BabbleWords! was created by'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text("Maciej Byczko"),
        Text("Filip Przygoński"),
        Text("Filip Sołdon"),
        Text("Jakub Tołściuk"),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close', style: TextStyle(color: AppColors.purple)),
      ),
    ],
  );
}

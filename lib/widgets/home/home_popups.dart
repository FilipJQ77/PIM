import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/screens/game.dart';
import 'package:pim_word_builder/widgets/home/choose_color_dropdown.dart';
import 'package:pim_word_builder/widgets/text_input_box.dart';

class StartGamePopup extends StatelessWidget {
  const StartGamePopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Enter players' names"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                TextInputBox(hintText: "Player 1"),
                TextInputBox(hintText: "Player 2")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Expanded(child: Center(child: ChooseColorDropDown())),
                Expanded(child: Center(child: ChooseColorDropDown())),
              ],
            )
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: AppColors.purple)),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Game()),
                      );
                    },
                    child: const Text(
                      'Start Game!',
                      style: TextStyle(color: AppColors.purple),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]);
  }
}

class RulesPopup extends StatelessWidget {
  const RulesPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Rules',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text("Description\n",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "BabbleWords! is a word game in which two players score points by "
                "placing tiles, each bearing a single letter, "
                "onto a game board divided into a 15×15 grid of squares. "
                "The tiles must form words that, in crossword fashion, "
                "read 'left to right' in rows or 'downward' in columns, "
                "and be included in a standard dictionary or lexicon.",
                textAlign: TextAlign.justify),
            Text("\nGameplay\n", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "1. The first player combines two or more of their letters to form "
                "a word and places it on the board to read either across "
                "or down with one letter on the center square. "
                "Diagonal words are not allowed.\n",
                textAlign: TextAlign.justify),
            Text(
                "2. The player completes their turn by clicking the End Turn Button. "
                "If a player cannot think of a word, "
                "they can also pass their round without placing a tile.\n",
                textAlign: TextAlign.justify),
            Text(
                "3. Then each player in turn, adds one or more letters to those "
                "already placed to form new words. All letters played "
                "on a turn must be placed in one row across or down the board, "
                "to form at least one complete word. If, at the same time, "
                "they touch others letters in adjacent rows, "
                "those must also form complete words, crossword fashion, "
                "with all such letters. The player gets full credit "
                "for all words formed or modified on his or her turn.\n",
                textAlign: TextAlign.justify),
            Text(
                "4. New words may be formed by:\n"
                " - Adding one or more letters to a word or letters"
                " already on the board.\n"
                " - Placing a word at right angles to a word already on the board. "
                "The new word must use one of the letters already on the board "
                "or must add a letter to it.\n"
                " - Placing a complete word parallel to a word already played "
                "so that adjacent letters also form complete words.",
                textAlign: TextAlign.justify),
            Text("\nBonuses\n", style: TextStyle(fontWeight: FontWeight.bold)),
            Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "Red Tiles: ",
                        style: TextStyle(color: AppColors.red)),
                    TextSpan(
                      text: 'Word points are tripled.\n\n',
                    ),
                    TextSpan(
                        text: "Pink Tiles",
                        style: TextStyle(color: AppColors.pink)),
                    TextSpan(text: " and "),
                    TextSpan(
                        text: "Gold Tile: ",
                        style: TextStyle(color: AppColors.gold)),
                    TextSpan(
                      text: "Word points are doubled.\n\n",
                    ),
                    TextSpan(
                        text: "Dark Blue Tiles: ",
                        style: TextStyle(color: AppColors.darkBlue)),
                    TextSpan(
                      text: "Letter on the tile counts triple.\n\n",
                    ),
                    TextSpan(
                        text: "Light Blue Tiles: ",
                        style: TextStyle(color: AppColors.aqua)),
                    TextSpan(
                      text: "Letter on the tile counts double.\n\n",
                    ),
                  ],
                ),
                textAlign: TextAlign.justify),
            Text(
                "Each bonus can only be used once, "
                "the effect of two premium squares are multiplying.\n\n",
                textAlign: TextAlign.justify),
            Text("Jackpot!\n",
                style: TextStyle(
                    color: AppColors.purple, fontWeight: FontWeight.bold)),
            Text(
                "If a player plays all seven tiles from their hand on a turn, "
                "they score a bonus of 50 points after counting"
                " all other points from the turn.",
                textAlign: TextAlign.justify)
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Okay, got it!",
              style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

class AuthorsPopup extends StatelessWidget {
  const AuthorsPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

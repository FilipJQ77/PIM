import 'package:flutter/cupertino.dart';
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
                style: TextStyle(
                    color: AppColors.purple, fontWeight: FontWeight.bold)),
            Text(
                "\"BabbleWords!\" is a word game in which two players score points by "
                "placing tiles, each bearing a single letter, "
                "onto a game board divided into a 15×15 grid of squares. "
                "The tiles must form words that, in crossword fashion, "
                "read \"left to right\" in rows or \"downward\" in columns, "
                "and be included in a standard dictionary or lexicon.",
                textAlign: TextAlign.justify),
            Text("\nGameplay\n",
                style: TextStyle(
                    color: AppColors.purple, fontWeight: FontWeight.bold)),
            Text(
                "Each player has 2 minutes to place some of their tiles "
                "on the board to create existing word(s). "
                "After that time the round is automatically ended "
                "and the next player has their turn.\n",
                textAlign: TextAlign.justify),
            Text(
                "1. The first player combines two or more of their letters from \"hand\" to form "
                "a word and places it on the board to read either across "
                "or down with one word starting on the center square. "
                "Diagonal words are not allowed!\n",
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
            Text("\nBonuses\n",
                style: TextStyle(
                    color: AppColors.purple, fontWeight: FontWeight.bold)),
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
                "Bonuses can be be used multiple times. "
                "If many bonuses apply, their effect is multiplied.\n\n",
                textAlign: TextAlign.justify),
            Text("Buttons\n",
                style: TextStyle(
                    color: AppColors.purple, fontWeight: FontWeight.bold)),
            Text(
                "On the screen there are 4 different buttons:\n\n"
                "Undo - put last played tile back into player hand.\n\n"
                "Exchange - choose a letter and change it into a different one. "
                "Only available if a player has not put a tile on the board. "
                "Automatically ends player turn.\n\n"
                "Shuffle - change all player letters into different ones from "
                "the letter bag. Only available if a player has not put a tile "
                "on the board. Automatically ends player turn.\n\n"
                "End turn - if a player put some tiles on the board, "
                "and they make acceptable words, the player gets appropriate "
                "points for them. If a player has not put any letters "
                "on the board, they can simply pass a turn without doing anything.\n",
                textAlign: TextAlign.justify),
            Text("Jackpot!\n",
                style: TextStyle(
                    color: AppColors.purple, fontWeight: FontWeight.bold)),
            Text(
                "If a player plays all seven tiles from their hand on a turn, "
                "they score a bonus of 50 points after counting "
                "all other points from the turn.",
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

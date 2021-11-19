import 'package:flutter/material.dart';
import 'package:pim_word_builder/board.dart';
import 'package:pim_word_builder/board_timer.dart';
import 'package:pim_word_builder/hand_letter.dart';
import 'package:pim_word_builder/function_button.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/letter_bag.dart';

class BoardScreen extends StatefulWidget {
  List<HandLetter> handLetters = [];
  static String lastClickedLetter = "X";

  static void setLastLetter(String letter) {
    lastClickedLetter = letter;
    print("OK $letter");
  }

  static String getLastLetter() {
    return lastClickedLetter;
  }

//
  BoardScreen({Key? key}) : super(key: key) {
    const int numberOfLetters = 7;
    var letterBag = LetterBag();
    List<String> playerLetters = letterBag.getLettersFromBag(numberOfLetters);
    for (int i = 0; i < numberOfLetters; i++) {
      handLetters
          .add(HandLetter(handLetterId: i, letterValue: playerLetters[i]));
    }
  }

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // TIMER ETC
        children: [
          Expanded(
            // flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Center(
                      child: Row(
                        children: const <Widget>[
                          Text("    Gracz 1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.navyBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Icon(Icons.accessibility,
                              size: 30, color: AppColors.purple),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: const Center(
                      child: Text(
                        "Round\nTimer",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Center(
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.accessibility,
                              size: 30, color: AppColors.purple),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Text("Gracz 2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.navyBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            // flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: const Center(
                      child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "Punkty\n69",
                            style: TextStyle(color: AppColors.black),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: const Center(
                      child: BoardTimer(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: const Center(
                      child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "Punkty\n69",
                            style: TextStyle(color: AppColors.black),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // TIMER ETC
          // BOARD
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                      color: AppColors.misty,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Board()),
                      )),
                ),
              ],
            ),
          ),

          // HAND
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Row(
                      children: widget.handLetters,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // BUTTONS
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FunctionButton(icon: Icons.undo_rounded, text: 'UNDO'),
                        FunctionButton(
                            icon: Icons.change_circle_rounded,
                            text: 'EXCHANGE'),
                        FunctionButton(
                            icon: Icons.shuffle_on_rounded, text: 'SHUFFLE'),
                        FunctionButton(
                            icon: Icons.skip_next_rounded, text: 'END TURN'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

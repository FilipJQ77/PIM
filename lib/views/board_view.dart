import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/board.dart';
import 'package:pim_word_builder/widgets/board_timer.dart';
import 'package:pim_word_builder/widgets/hand_letter.dart';
import 'package:pim_word_builder/widgets/function_button.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/letter_bag.dart';

class BoardView extends StatefulWidget {
  List<HandLetter> handLetters = [];

  // board and board state refs
  GlobalKey<BoardState> myBoardKey = GlobalKey();
  Board board = Board();

  BoardView({Key? key}) : super(key: key)
  {
    // overwrite board ref with new board ref but this time with key (board state ref)
    board = Board(key: myBoardKey);
    const int numberOfLetters = 7;
    var letterBag = LetterBag();
    List<String> playerLetters = letterBag.getLettersFromBag(numberOfLetters);
    for (int i = 0; i < numberOfLetters; i++) {
      handLetters
          .add(HandLetter(handLetterId: i, letterValue: playerLetters[i], boardStateRef: myBoardKey,));
    }
  }

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Icon(Icons.accessibility,
                              size: 50, color: AppColors.lightPurple),
                          Text("Player 1",
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
                const Expanded(
                    child: Center(
                        child: Text("Easter Egg HAHAHA",
                            style: TextStyle(color: AppColors.white)))),
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Icon(Icons.accessibility,
                              size: 50, color: AppColors.purple),
                          Text("Player 2",
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
                    child: Column(
                      children: [
                        const Center(
                            child: Text("Points",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.black,
                              elevation: 10,
                            ),
                            onPressed: () {},
                            child: const Text("69"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Column(
                      children: const <Widget>[
                        Text("Round Timer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        BoardTimer(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Column(
                      children: [
                        const Center(
                            child: Text("Points",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.black,
                              elevation: 10,
                            ),
                            onPressed: () {},
                            child: const Text("69"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // TIMER ETC
          // BOARD
          Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                      color: AppColors.misty,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: widget.board),
                      )),
                ),
              ],
            ),
          ),

          // HAND
          Expanded(
            // flex: 1,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      children: [
                        FunctionButton(icon: Icons.undo_rounded, text: 'UNDO', boardStateRef: widget.myBoardKey,),
                        FunctionButton(
                            icon: Icons.change_circle_rounded,
                            text: 'EXCHANGE', boardStateRef: widget.myBoardKey,),
                        FunctionButton(
                            icon: Icons.shuffle_on_rounded, text: 'SHUFFLE', boardStateRef: widget.myBoardKey,),
                        FunctionButton(
                            icon: Icons.skip_next_rounded, text: 'END TURN', boardStateRef: widget.myBoardKey,),
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

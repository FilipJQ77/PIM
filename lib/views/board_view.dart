import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/board.dart';
import 'package:pim_word_builder/widgets/hand_letter.dart';
import 'package:pim_word_builder/letter_bag.dart';

class BoardView extends StatefulWidget {
  List<HandLetter> handLetters = [];

  // board and board state refs
  GlobalKey<BoardState> myBoardKey = GlobalKey();
  Board board = Board();

  BoardView({Key? key}) : super(key: key) {
    // overwrite board ref with new board ref but this time with key (board state ref)
    board = Board(key: myBoardKey);
    const int numberOfLetters = 7;
    var letterBag = LetterBag();
    List<String> playerLetters = letterBag.getLettersFromBag(numberOfLetters);
    for (int i = 0; i < numberOfLetters; i++) {
      handLetters.add(HandLetter(
        handLetterId: i,
        letterValue: playerLetters[i],
        boardStateRef: myBoardKey,
      ));
    }
  }

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

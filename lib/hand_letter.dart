import 'package:flutter/material.dart';
import 'dart:math';

// todo implement this in the hand below
class HandLetter extends StatefulWidget {
  const HandLetter({Key? key}) : super(key: key);

  @override
  _HandLetterState createState() => _HandLetterState();
}

class _HandLetterState extends State<HandLetter> {
  String letter = "";

  void setLetter(String letter) {
    if (letter.length != 1) {
      throw Exception("The string should only be 1 letter");
      //TODO better exception
    }
    setState(() {
      this.letter = letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextButton(
            onPressed: () {  },
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFF273a46),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xfffaf9fa)),
              ),
              child: Center(child: Text(letter)),
            ),
          ),
        ],
      ),
    );
  }
}

class LetterBag {
  /*
    source: https://en.wikipedia.org/wiki/Scrabble_letter_distributions
    - 100 letters

    - 2 blank tiles (0 p.)
    - E ×12, A ×9, I ×9, O ×8, N ×6, R ×6, T ×6, L ×4, S ×4, U ×4 (1 p.)
    - D ×4, G ×3 (2 p.)
    - B ×2, C ×2, M ×2, P ×2 (3 p.)
    - F ×2, H ×2, V ×2, W ×2, Y ×2 (4 p.)
    - K ×1 (5 p.)
    - J ×1, X ×1 (8 p.)
    - Q ×1, Z ×1 (10 p.)

    - Each player draws seven letters
  */
  final _random = Random();
  List<String> letters = [];

  LetterBag() {
    fillBag();
  }

  void fillBagWithLetter(String letter, int numberOfRepetitions) {
    for (var i = 0; i < numberOfRepetitions; i++) {
      letters.add(letter);
    }
  }

  void fillBag() {
    // blank tile - 0p
    fillBagWithLetter(' ', 2);
    // 1p
    fillBagWithLetter('E', 12);
    fillBagWithLetter('A', 9);
    fillBagWithLetter('I', 9);
    fillBagWithLetter('O', 8);
    fillBagWithLetter('N', 6);
    fillBagWithLetter('R', 6);
    fillBagWithLetter('T', 6);
    fillBagWithLetter('L', 4);
    fillBagWithLetter('S', 4);
    fillBagWithLetter('U', 4);
    // 2p
    fillBagWithLetter('D', 4);
    fillBagWithLetter('G', 3);
    // 3p
    fillBagWithLetter('B', 2);
    fillBagWithLetter('C', 2);
    fillBagWithLetter('M', 2);
    fillBagWithLetter('P', 2);
    // 4p
    fillBagWithLetter('F', 2);
    fillBagWithLetter('H', 2);
    fillBagWithLetter('V', 2);
    fillBagWithLetter('W', 2);
    fillBagWithLetter('Y', 2);
    // 5p
    fillBagWithLetter('K', 1);
    // 8p
    fillBagWithLetter('J', 1);
    fillBagWithLetter('X', 1);
    // 10p
    fillBagWithLetter('Q', 1);
    fillBagWithLetter('Z', 1);
  }

  static int getLetterValue(String letter) {
    switch (letter) {
      case 'Q':
      case 'Z':
        return 10;
      case 'J':
      case 'X':
        return 8;
      case 'K':
        return 5;
      case 'F':
      case 'H':
      case 'V':
      case 'W':
      case 'Y':
        return 4;
      case 'B':
      case 'C':
      case 'M':
      case 'P':
        return 3;
      case 'D':
      case 'G':
        return 2;
      case 'A':
      case 'E':
      case 'I':
      case 'L':
      case 'N':
      case 'O':
      case 'R':
      case 'S':
      case 'T':
      case 'U':
        return 1;
      case ' ':
        return 0;
      default:
        throw Exception(
            "Cannot get value of something that's not a correct tile");
    }
  }

  int getBagSize() {
    return letters.length;
  }

  /*
     Generates a random integer uniformly distributed
     from [min], inclusive, to [max], exclusive.
    */
  int randomInt(int min, int max) => min + _random.nextInt(max - min);

  Iterable<String> getLettersFromBag(int numberOfLetters) {
    if (numberOfLetters > getBagSize()) {
      throw Exception("The letter bag does not have enough tiles");
    }
    List<String> drawnLetters = [];
    for (var i = 0; i < numberOfLetters; i++) {
      drawnLetters.add(letters.removeAt(randomInt(0, getBagSize())));
    }

    return drawnLetters;
  }

  Iterable<String> drawHand() {
    return getLettersFromBag(7);
  }

  void addLettersToBag(Iterable<String> lettersToAdd) {
    letters.addAll(lettersToAdd);
  }

  bool isEmpty() {
    if (getBagSize() != 0) return false;
    return true;
  }
}
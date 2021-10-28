import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BabbleWords!',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      //TODO Create our own purple MaterialColor
      home: Scaffold(
          appBar: AppBar(
            title: const Text('BabbleWords!'),
          ),
          body: const BoardScreen()),
    );
  }
}

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
        children: [
          Expanded(
            child: Center(child: Text(letter)),
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

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // BOARD
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                      color: Colors.cyan,
                      child: Center(child: Text('board here'))),
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
                    color: Colors.yellow,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    color: Colors.grey[400],
                                    child: Center(child: Text('A'))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    color: Colors.grey[600],
                                    child: Center(child: Text('B'))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    color: Colors.grey[400],
                                    child: Center(child: Text('C'))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    color: Colors.grey[600],
                                    child: Center(child: Text('D'))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    color: Colors.grey[400],
                                    child: Center(child: Text('E'))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    color: Colors.grey[600],
                                    child: Center(child: Text('F'))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                    color: Colors.grey[400],
                                    child: Center(child: Text('G'))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // BUTTONS
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    //padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    color: Colors.green,
                    // child: Center(child: Text('buttons here')),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                primary: Colors.amber,
                                onPrimary: Colors.black),
                            icon: const Icon(
                              Icons.undo_rounded,
                              //color: Colors.white,
                              size: 20.0,
                            ),
                            label: const Text('UNDO'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                primary: Colors.amber,
                                onPrimary: Colors.black),
                            icon: const Icon(
                              Icons.change_circle_rounded,
                              //color: Colors.white,
                              size: 20.0,
                            ),
                            label: const Text('EXCHANGE'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                primary: Colors.amber,
                                onPrimary: Colors.black),
                            icon: const Icon(
                              Icons.shuffle_on_rounded,
                              //color: Colors.white,
                              size: 20.0,
                            ),
                            label: const Text('SHUFFLE'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                primary: Colors.amber,
                                onPrimary: Colors.black),
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              //color: Colors.white,
                              size: 20.0,
                            ),
                            //color: Colors.amber,
                            label: const Text('PASS'),
                          ),
                        )
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

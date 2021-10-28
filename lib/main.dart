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

    - 2 blank tiles (0 p.) (maybe temporary without blanks?)
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
  List <String> letters = [];

  LetterBag(){
    fillBag();
  }

  void addLetterToBag(String letter, int numberOfRepetitions){
    for(var i=0;i<numberOfRepetitions;i++) {letters.add(letter);}
  }

  void fillBag() {
    // TODO add blanks - 0p, temporary without blanks in bag
    // 1p
    addLetterToBag('E', 12);
    addLetterToBag('A', 9);
    addLetterToBag('I', 9);
    addLetterToBag('O', 8);
    addLetterToBag('N', 6);
    addLetterToBag('R', 6);
    addLetterToBag('T', 6);
    addLetterToBag('L', 4);
    addLetterToBag('S', 4);
    addLetterToBag('U', 4);
    // 2p
    addLetterToBag('D', 4);
    addLetterToBag('G', 3);
    // 3p
    addLetterToBag('B', 2);
    addLetterToBag('C', 2);
    addLetterToBag('M', 2);
    addLetterToBag('P', 2);
    // 4p
    addLetterToBag('F', 2);
    addLetterToBag('H', 2);
    addLetterToBag('V', 2);
    addLetterToBag('W', 2);
    addLetterToBag('Y', 2);
    // 5p
    addLetterToBag('K', 1);
    // 8p
    addLetterToBag('J', 1);
    addLetterToBag('X', 1);
    // 10p
    addLetterToBag('Q', 1);
    addLetterToBag('Z', 1);
  }

  // TODO we can move it to other class
  int getLetterValue(String letter){
    if (letter == 'Q' || letter == 'Z') {return 10;}
    else if(letter == 'J' || letter == 'X') {return 8;}
    else if(letter == 'K') {return 5;}
    else if(letter == 'F' || letter == 'H' || letter == 'V' || letter == 'W' || letter == 'Y') {return 4;}
    else if(letter == 'B' || letter == 'C' || letter == 'M' || letter == 'P') {return 3;}
    else if(letter == 'D' || letter == 'G') {return 2;}
    else if(letter == ' ') {return 0;} // blanks
    return 1; // E, A, I, O ... S, U
  }

  int getBagSize(){
    return letters.length;
  }


  /*
     Generates a positive random integer uniformly distributed on the range
     from [min], inclusive, to [max], exclusive.
    */
  int randomInt(int min, int max) => min + _random.nextInt(max - min);

  String drawOneLetter(){
    String letter = letters.removeAt(randomInt(0, getBagSize()));
    return letter;
  }

  List <String> drawHand(){
    List <String> hand = [];
    for(var i=0;i<7;i++) {hand.add(drawOneLetter());}
    return hand;
  }

  bool isEmpty(){
    if( getBagSize() != 0) return false;
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
                      child: Center(child: Text('board here'))
                  ),
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
                                    child: Center(child: Text('A'))
                                  ),
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
                                      child: Center(child: Text('B'))
                                  ),
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
                                      child: Center(child: Text('C'))
                                  ),
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
                                      child: Center(child: Text('D'))
                                  ),
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
                                      child: Center(child: Text('E'))
                                  ),
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
                                      child: Center(child: Text('F'))
                                  ),
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
                                      child: Center(child: Text('G'))
                                  ),
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
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child:ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                  ),
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
                                    borderRadius: BorderRadius.circular(30)
                                ),
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
                                      borderRadius: BorderRadius.circular(30)
                                  ),
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
                                      borderRadius: BorderRadius.circular(30)
                                  ),
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


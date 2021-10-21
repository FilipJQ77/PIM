import 'package:flutter/material.dart';

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

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Babble Words!'),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
      ),
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


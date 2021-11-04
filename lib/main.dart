import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pim_word_builder/function_button.dart';
import 'package:pim_word_builder/home_screen.dart';
import 'package:pim_word_builder/board.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

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
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/images/BabbleHome.png',
                        color: const Color(0xFF89E41B)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 120,
                  ),
                ],
              )),
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
                      color: Colors.yellow,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: const Center(
                            child: Board()
                        ),
                      )
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
                                    child: const Center(child: Text('A'))),
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
                                    child: const Center(child: Text('B'))),
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
                                    child: const Center(child: Text('C'))),
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
                                    child: const Center(child: Text('D'))),
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
                                    child: const Center(child: Text('E'))),
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
                                    child: Center(child: const Text('F'))),
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
                                    child: const Center(child: Text('G'))),
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
                    color: const Color(0xFF761be4),
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
                            icon: Icons.skip_next_rounded, text: 'PASS'),
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

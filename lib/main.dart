import 'package:flutter/material.dart';
import 'package:pim_word_builder/hand_letter.dart';

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
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
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

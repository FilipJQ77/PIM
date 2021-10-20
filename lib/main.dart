import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //later on it should be changed for home screen or menu
    home: BoardScreen(),
  ));
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
                      child: Center(child: Text('buttons here'))
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


import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
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
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      color: Colors.cyan,
                      child: Text('board here')
                  ),
                ),
              ],
            ),
          ),
          // HAND
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.yellow,
                    child: Text('hand here')
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
                      child: Text('buttons here')
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


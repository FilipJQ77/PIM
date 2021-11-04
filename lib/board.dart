import 'package:flutter/material.dart';
import 'package:pim_word_builder/board_tile.dart';

// Scrable board size -> 15x15

final int BOARD_SIZE = 15;

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 8,
    ),
  );
}

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.cyan,
      decoration: myBoxDecoration(),
      child: Column(
        children: [
          for (var i = 1; i <= BOARD_SIZE; i++)
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  for (var j = 1; j <= BOARD_SIZE; j++)
                    Expanded(child: BoardTile(text: " ", isTaken: true, xCoord: j, yCoord: i))],
                ),
            ),
        ],
      ),
    );
  }
}

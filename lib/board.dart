import 'package:flutter/material.dart';
import 'package:pim_word_builder/board_tile.dart';

// Scrabble board size -> 15x15

const int boardSize = 15;

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: const Color(0xFF273a46),
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
      decoration: myBoxDecoration(),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: [
            for (var i = 1; i <= boardSize; i++)
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    for (var j = 1; j <= boardSize; j++)
                      Expanded(
                          child: BoardTile(
                              text: " ", isTaken: false, xCoord: j, yCoord: i))
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

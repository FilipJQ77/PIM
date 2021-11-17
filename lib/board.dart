import 'package:flutter/material.dart';
import 'package:pim_word_builder/board_tile.dart';
import 'package:pim_word_builder/board_screen.dart';
import 'package:pim_word_builder/app_colors.dart';

// Scrabble board size -> 15x15

const int boardSize = 15;

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: AppColors.navyBlue,
      width: 2,
    ),
  );
}

class Board extends StatefulWidget {
  //final array = List.generate(rows,
  //(i) => List.generate(cols + 1, (j) => i + j * cols + 1, growable: false),
  //growable: false);
  //List<List<BoardTile>> tiles = List.generate(boardSize, (_) => List(boardSize), growable: false);
  List<List<BoardTile>> tiles = [[]];

  Board({Key? key}) : super(key: key) {
    for (var i = 0; i < boardSize; i++) {
      tiles.add(<BoardTile>[]);
      for (var j = 0; j < boardSize; j++) {
        tiles[i]
            .add(BoardTile(text: " ", isTaken: false, xCoord: i, yCoord: j));
      }
    }
  }

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
            for (var i = 0; i < boardSize; i++)
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    for (var j = 0; j < boardSize; j++)
                      Expanded(
                        child: widget.tiles[i][j],

                        // onTap: () {
                        //   widget.tiles[i][j].text =
                        //       BoardScreen.getLastLetter();
                        // }
                      )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

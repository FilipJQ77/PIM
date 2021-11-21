import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/board_tile.dart';
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

  List<List<BoardTile>> tiles = [[]];

  Board({Key? key}) : super(key: key) {
    for (var i = 0; i < boardSize; i++) {
      tiles.add(<BoardTile>[]);
      for (var j = 0; j < boardSize; j++) {
        tiles[i].add(BoardTile(
          text: " ",
          isTaken: false,
          xCoord: i,
          yCoord: j,
          tileColor: TileParams.tileColor(i, j),
        ));
      }
    }
    tiles[7][7].text = "🌟";
  }

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {

  void removeLetterFromBoard(int x, int y){
    print("Triggered removeLetterFromBoard");
    var text = " ";
    if(x == 7  && y == 7) text = "🌟"; // middle tile
    setState(() {

      widget.tiles[x][y] = BoardTile(
        text: text,
        isTaken: false,
        xCoord: x,
        yCoord: y,
        tileColor: TileParams.tileColor(x, y),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: myBoxDecoration(),
      child: InteractiveViewer(
        // panEnabled: true,
        minScale: 1,
        maxScale: 4,
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/game/board_tile.dart';
import 'package:pim_word_builder/app_colors.dart';

// Scrabble board size -> 15x15

const int boardSize = 15;

class Board extends StatefulWidget {
  List<List<BoardTile>> tiles = [[]];
  List<List<GlobalKey<BoardTileState>>> myBoardTilesKeys = [[]];

  // test

  Board({Key? key}) : super(key: key) {
    for (var i = 0; i < boardSize; i++) {
      tiles.add(<BoardTile>[]);
      myBoardTilesKeys.add(<GlobalKey<BoardTileState>>[]);
      for (var j = 0; j < boardSize; j++) {
        GlobalKey<BoardTileState> myBoardTileKey = GlobalKey();
        tiles[i].add(BoardTile(
            text: " ",
            isTaken: false,
            xCoord: i,
            yCoord: j,
            tileColor: TileParams.tileColor(i, j),
            key: myBoardTileKey));
        myBoardTilesKeys[i].add(myBoardTileKey);
      }
    }
    tiles[7][7].text = "🌟";
  }

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  String lastClickedLetter = "None";
  List<int> lastClickedLetterXCoords = [];
  List<int> lastClickedLetterYCoords = [];

  void setLastClickedLetter(String letter) {
    setState(() {
      lastClickedLetter = letter;
    });
    print("Last clicked hand letter:");
    print(lastClickedLetter);
  }

  List<int> getLastClickedLetterXCoords() {
    return lastClickedLetterXCoords;
  }

  List<int> getLastClickedLetterYCoords() {
    return lastClickedLetterYCoords;
  }

  void removeLetterFromBoard(int x, int y) {
    print("Triggered removeLetterFromBoard");
    var text = " ";
    if (x == 7 && y == 7) text = "🌟"; // middle tile
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
    return Expanded(
      flex: 5,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          // child: Center(child: widget.board),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.navyBlue,
                width: 2,
              ),
            ),
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
                                child: GestureDetector(
                                    onTap: () {
                                      print("Clicked on tile in board");
                                      if (lastClickedLetter == "None") {
                                        return;
                                      } // if none letter -> quit
                                      print("Clicked on tile ($i,$j)");
                                      lastClickedLetterXCoords.add(i);
                                      lastClickedLetterYCoords.add(j);
                                      widget
                                          .myBoardTilesKeys[i][j].currentState!
                                          .placeLetterOnTile(lastClickedLetter);
                                      lastClickedLetter = "None";
                                    },
                                    child: widget.tiles[i][j]),

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
          )),
    );
  }
}

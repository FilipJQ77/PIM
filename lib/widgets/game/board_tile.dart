import 'package:flutter/material.dart';
import '../../app_colors.dart';

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: AppColors.navyBlue,
      width: 1,
    ),
  );
}

class BoardTile extends StatefulWidget {
  String text;
  bool isTaken; // if tile is taken -> letter is placed on the tile
  final int xCoord;
  final int yCoord;
  Color tileColor;
  BoardTile(
      {Key? key,
      required this.text,
      required this.isTaken,
      required this.xCoord,
      required this.yCoord,
      required this.tileColor})
      : super(key: key);

  @override
  BoardTileState createState() => BoardTileState();
}

class BoardTileState extends State<BoardTile> {

  void placeLetterOnTile(String letter){
    setState(() {
      widget.text = letter;
      widget.isTaken = true;
      widget.tileColor = AppColors.cream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.tileColor,
          border: Border.all(color: AppColors.black)),

      // color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
            child: Text(widget.text,
                style: const TextStyle(fontWeight: FontWeight.bold))),
      ),
    );
  }
}

class TileParams {
  static Color tileColor(int x, int y) {
    Color colour = AppColors.green;
    if ((x == y) || (x + y == 14)) {
      colour = AppColors.pink;
    }
    if (((x == 0 || x == 14) && (y == 0 || y == 7 || y == 14)) ||
        (x == 7 && (y == 0 || y == 14))) {
      colour = AppColors.red;
    }
    if (((x == 5 || x == 9) && (y == 1 || y == 5 || y == 9 || y == 13)) ||
        ((x == 1 || x == 13) && (y == 5 || y == 9))) {
      colour = AppColors.darkBlue;
    }
    if (((x == 0 || x == 7 || x == 14) && (y == 3 || y == 11)) ||
        ((x == 3 || x == 11) && (y == 0 || y == 7 || y == 14)) ||
        ((x == 2 || x == 6 || x == 8 || x == 12) && (y == 6 || y == 8)) ||
        ((y == 2 || y == 6 || y == 8 || y == 12) && (x == 6 || x == 8))) {
      colour = AppColors.aqua;
    }
    // if (x == 7 && y == 7) {
    //   colour = AppColors.transparentGray;
    // }
    return colour;
  }
}

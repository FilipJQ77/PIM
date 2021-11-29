import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

class BoardTile extends StatefulWidget {
  final int x;
  final int y;

  const BoardTile({Key? key, required this.x, required this.y})
      : super(key: key);

  @override
  _BoardTileState createState() => _BoardTileState();

  static Color getTileColor(int x, int y) {
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
    if (x == 7 && y == 7) {
      colour = AppColors.gold;
    }
    return colour;
  }
}

class _BoardTileState extends State<BoardTile> {
  late String letter;
  late bool isTaken;
  late Color tileColor;

  @override
  void initState() {
    super.initState();
    letter = "";
    isTaken = false;
    tileColor = BoardTile.getTileColor(widget.x, widget.y);
  }

  void placeLetterOnTile(String letter) {
    setState(() {
      if (!isTaken) {
        this.letter = letter;
        isTaken = true;
        tileColor = AppColors.cream;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tileColor, border: Border.all(color: AppColors.black)),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
            child: Text(letter,
                style: const TextStyle(fontWeight: FontWeight.bold))),
      ),
    );
  }
}

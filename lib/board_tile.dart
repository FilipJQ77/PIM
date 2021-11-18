import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/board_screen.dart';

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
  final bool isTaken; // if tile is taken -> letter is placed on the tile
  final int xCoord;
  final int yCoord;
  BoardTile(
      {Key? key,
      required this.text,
      required this.isTaken,
      required this.xCoord,
      required this.yCoord})
      : super(key: key);

  @override
  _BoardTileState createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int x = widget.xCoord;
        int y = widget.yCoord;
        print("Clicked on tile ($x,$y)");
        setState(() {
          widget.text = BoardScreen.getLastLetter();
        });
      },
      child: Container(
        decoration: myBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(child: Text(widget.text)),
        ),
      ),
    );
  }
}

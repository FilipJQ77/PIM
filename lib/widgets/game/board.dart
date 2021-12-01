import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/game/board_tile.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/screens/game.dart' show boardSize;

class Board extends StatelessWidget {
  final List<List<BoardTile>> boardTiles;

  const Board({Key? key, required this.boardTiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.navyBlue,
              width: 2,
            ),
          ),
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: AspectRatio(
              aspectRatio: 1,
              child: Column(
                children: [
                  for (var i = 0; i < boardSize; i++)
                    Expanded(
                      child: Row(
                        children: [
                          for (var j = 0; j < boardSize; j++) boardTiles[i][j]
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}

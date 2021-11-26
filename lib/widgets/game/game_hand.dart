import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

class GameHand extends StatelessWidget {
  const GameHand({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: AppColors.mistyWhite,
              child: Row(
                // todo
                // children: widget.handLetters,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
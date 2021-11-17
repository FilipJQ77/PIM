import 'package:flutter/material.dart';
import 'package:pim_word_builder/board.dart';
import 'package:pim_word_builder/hand_letter.dart';
import 'package:pim_word_builder/function_button.dart';
import 'package:pim_word_builder/app_colors.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // BOARD
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                      color: AppColors.misty,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: Board()),
                      )),
                ),
              ],
            ),
          ),
          // HAND
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Row(
                      children: [
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // BUTTONS
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FunctionButton(icon: Icons.undo_rounded, text: 'UNDO'),
                        FunctionButton(
                            icon: Icons.change_circle_rounded,
                            text: 'EXCHANGE'),
                        FunctionButton(
                            icon: Icons.shuffle_on_rounded, text: 'SHUFFLE'),
                        FunctionButton(
                            icon: Icons.skip_next_rounded, text: 'END TURN'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
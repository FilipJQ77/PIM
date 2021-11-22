import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/board_screen.dart';

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    color: AppColors.navyBlue,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: AppColors.misty),
  );
}

// todo implement this in the hand below
class HandLetter extends StatefulWidget {
  String letterValue = "";
  final int handLetterId;

  HandLetter({Key? key, required this.handLetterId, required this.letterValue})
      : super(key: key);

  @override
  _HandLetterState createState() => _HandLetterState();
}

class _HandLetterState extends State<HandLetter> {
  String letter = "";

  void setLetter(String letter) {
    if (letter.length != 1) {
      throw Exception("The string should only be 1 letter");
      //TODO better exception
    }
    setState(() {
      this.letter = letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              BoardScreen.setLastLetter(widget.letterValue);
              print(widget.letterValue);
              print(widget.handLetterId);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: myBoxDecoration(),
              child: AspectRatio(
                aspectRatio: 1,
                child: Center(
                    child: Text(widget.letterValue,
                        style: const TextStyle(
                            color: AppColors.misty,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

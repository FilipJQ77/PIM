import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';

class HandLetter extends StatelessWidget {
  final String letter;
  final Function(HandLetter thisLetter) newCurrentLetter;

  const HandLetter(
      {Key? key, required this.letter, required this.newCurrentLetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 55,
      maxWidth: 55,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextButton(
          onPressed: () {
            print(letter);
            newCurrentLetter(this);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.mistyWhite),
            ),
            child: Center(
                child: Text(letter,
                    style: const TextStyle(
                        color: AppColors.mistyWhite,
                        fontWeight: FontWeight.bold))),
          ),
        ),
      ),
    );
  }
}

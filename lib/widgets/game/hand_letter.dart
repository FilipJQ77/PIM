import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';

class HandLetter extends StatelessWidget {
  final String letter;
  final bool active;
  final Function(HandLetter thisLetter) newCurrentLetter;

  const HandLetter(
      {Key? key,
      required this.letter,
      required this.newCurrentLetter,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 40,
      maxWidth: 40,
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: active ? AppColors.purple : AppColors.navyBlue,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            print(letter);
            newCurrentLetter(this);
          },
          child: Text(letter,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.mistyWhite, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

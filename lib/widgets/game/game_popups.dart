import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

class ExchangePopup extends StatelessWidget {
  final List<HandLetter> playerLetters;
  final Function() exchangeChosenLetter;

  const ExchangePopup({Key? key,
    required this.playerLetters,
    required this.exchangeChosenLetter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose letter to exchange:'),
      content: Expanded(
        child: Column(
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: playerLetters.sublist(0, 4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: playerLetters.sublist(4, 7),
          ),
          ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            exchangeChosenLetter();
            Navigator.of(context).pop();
          },
          child: const Text('Exchange', style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

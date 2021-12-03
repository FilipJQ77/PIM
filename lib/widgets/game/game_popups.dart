import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

class ExchangePopup extends StatelessWidget {
  final HandLetter chosenLetter;
  final Function() exchangeChosenLetter;

  const ExchangePopup(
      {Key? key,
      required this.chosenLetter,
      required this.exchangeChosenLetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Do you want to exchange this letter?'),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.14,
        color: AppColors.mistyWhite,
        // color: AppColors.aqua, // testing
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            chosenLetter,
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child:
          const Text('NO', style: TextStyle(color: AppColors.purple)),
        ),
        TextButton(
          onPressed: () {
            exchangeChosenLetter();
            Navigator.of(context).pop();
          },
          child:
              const Text('YES', style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

class ShufflePopup extends StatelessWidget {
  final Function() shuffleHand;

  const ShufflePopup({Key? key,
  required this.shuffleHand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Do you want to shuffle letters?'),
      //content:
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child:
          const Text('NO', style: TextStyle(color: AppColors.purple)),
        ),
        TextButton(
          onPressed: () {
            shuffleHand();
            Navigator.of(context).pop();
          },
          child:
          const Text('YES', style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

class EndTurnPopup extends StatelessWidget {
  const EndTurnPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



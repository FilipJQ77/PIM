import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

class ExchangePopUp extends StatelessWidget {
  final List<HandLetter> playerLetters;
  final Function() function;

  const ExchangePopUp({Key? key,
    required this.playerLetters,
    required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose letter to exchange:'),
      content: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height*0.14,
              color: AppColors.mistyWhite,
              // color: AppColors.aqua, // testing
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
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            function();
            Navigator.of(context).pop();
          },
          child: const Text('Exchange', style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

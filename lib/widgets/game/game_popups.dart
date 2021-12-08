import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';
import 'package:pim_word_builder/screens/game_over.dart';
import 'package:pim_word_builder/classes/player.dart';

class ExchangePopup extends StatelessWidget {
  final HandLetter chosenLetter;
  final Function exchangeChosenLetter;

  const ExchangePopup(
      {Key? key,
      required this.chosenLetter,
      required this.exchangeChosenLetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exchange this letter?'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.14,
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
          child: const Text('NO', style: TextStyle(color: AppColors.purple)),
        ),
        TextButton(
          onPressed: () {
            exchangeChosenLetter();
            Navigator.of(context).pop();
          },
          child: const Text('YES', style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

class ShufflePopup extends StatelessWidget {
  final Function shuffleHand;

  const ShufflePopup({Key? key, required this.shuffleHand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Shuffle your letters?'),
      //content:
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('NO', style: TextStyle(color: AppColors.purple)),
        ),
        TextButton(
          onPressed: () {
            shuffleHand();
            Navigator.of(context).pop();
          },
          child: const Text('YES', style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

class EndTurnPopup extends StatelessWidget {
  final int pointsGained;
  final Function(int) endPlayerTurn;
  final List<Player> players;

  const EndTurnPopup(
      {Key? key, required this.endPlayerTurn, required this.pointsGained, required this.players})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('End turn?'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.10,
        child: Text("Points gained this round: $pointsGained",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('NO', style: TextStyle(color: AppColors.purple)),
        ),
        TextButton(
          onPressed: () {
            bool gameContinues = endPlayerTurn(pointsGained);
            Navigator.of(context).pop();
            if(!gameContinues){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameOver(players: players))
              );
            }

          },
          child: const Text('YES', style: TextStyle(color: AppColors.purple)),
        ),
      ],
    );
  }
}

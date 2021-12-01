import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

var _gameButtonStyle = ElevatedButton.styleFrom(
    // todo usunąć sztywne rozmiary lepiej
    minimumSize: const Size(88, 50),
    maximumSize: const Size(88, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    primary: AppColors.purple,
    onPrimary: AppColors.white,
    shadowColor: AppColors.purple);

class _GameButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  const _GameButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _gameButtonStyle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(icon, size: 30.0),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}

class UndoButton extends StatelessWidget {
  final Function undoFunction;

  const UndoButton({Key? key, required this.undoFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        text: "UNDO", icon: Icons.undo_rounded, onPressed: undoFunction);
  }
}

class ExchangeButton extends StatelessWidget {
  final Function exchangeFunction;

  const ExchangeButton({Key? key, required this.exchangeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        text: "EXCHANGE",
        icon: Icons.change_circle_rounded,
        onPressed: exchangeFunction);
  }
}

class ShuffleButton extends StatelessWidget {
  final Function shuffleFunction;

  const ShuffleButton({Key? key, required this.shuffleFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        text: "SHUFFLE",
        icon: Icons.shuffle_on_rounded,
        onPressed: shuffleFunction);
  }
}

class EndTurnButton extends StatelessWidget {
  final Function endTurnFunction;

  const EndTurnButton({Key? key, required this.endTurnFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        icon: Icons.skip_next_rounded,
        text: 'END TURN',
        onPressed: endTurnFunction);
  }
}

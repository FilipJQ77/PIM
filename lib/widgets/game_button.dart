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
  final Function function;

  const _GameButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.function})
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
        function();
      },
    );
  }
}

class UndoButton extends StatelessWidget {
  final Function function;

  const UndoButton({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        text: "UNDO", icon: Icons.undo_rounded, function: function);
  }
}

class ExchangeButton extends StatelessWidget {
  final Function function;

  const ExchangeButton({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        text: "EXCHANGE",
        icon: Icons.change_circle_rounded,
        function: function);
  }
}

class ShuffleButton extends StatelessWidget {
  final Function function;

  const ShuffleButton({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        text: "SHUFFLE", icon: Icons.shuffle_on_rounded, function: function);
  }
}

class EndTurnButton extends StatelessWidget {
  final Function function;

  const EndTurnButton({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GameButton(
        icon: Icons.skip_next_rounded, text: 'END TURN', function: function);
  }
}

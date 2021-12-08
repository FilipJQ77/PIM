import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/screens/home.dart';

var _homeButtonStyle = ElevatedButton.styleFrom(
  primary: AppColors.purple,
  onPrimary: AppColors.white,
  shadowColor: AppColors.purple,
  elevation: 3,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
  minimumSize: const Size(100, 40),
);

class _GenericHomeButton extends StatelessWidget {
  final String text;
  final Function function;

  const _GenericHomeButton({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _homeButtonStyle,
      child: Text(text),
      onPressed: () {
        function();
      },
    );
  }
}

class ReturnToMenuButton extends StatelessWidget {
  const ReturnToMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GenericHomeButton(
        text: "Return to menu",
        function: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        });
  }
}
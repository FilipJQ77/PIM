import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/home/home_popups.dart';
import 'dart:io' as io;

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

class StartGameButton extends StatelessWidget {
  const StartGameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GenericHomeButton(
        text: "Start Game",
        function: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const StartGamePopup(),
          );
        });
  }
}

class RulesButton extends StatelessWidget {
  const RulesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GenericHomeButton(
        text: "Rules",
        function: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const RulesPopup(),
          );
        });
  }
}

class AuthorsButton extends StatelessWidget {
  const AuthorsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GenericHomeButton(
        text: "Authors",
        function: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AuthorsPopup(),
          );
        });
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GenericHomeButton(
        text: "Exit",
        function: () {
          if (io.Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (io.Platform.isIOS) {
            io.exit(0);
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

class PlayerNameIcon extends StatelessWidget {
  final String playerName;

  const PlayerNameIcon({
    Key? key,
    required this.playerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.misty,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Icon(Icons.accessibility,
                  size: 50, color: AppColors.lightPurple),
              Text(playerName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.navyBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
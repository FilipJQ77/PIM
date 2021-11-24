import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

// todo przerobic to potem na stateful PORZĄDNIE
class PlayerInfo extends StatelessWidget {
  final String playerName;
  final int points;

  const PlayerInfo({
    Key? key,
    required this.playerName,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.mistyWhite,
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
              const Center(
                  child: Text("Points",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.black,
                    elevation: 10,
                  ),
                  onPressed: () {},
                  child: Text(points.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

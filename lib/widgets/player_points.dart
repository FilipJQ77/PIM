import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

// todo przerobić poźniej na stateful
class PlayerPoints extends StatelessWidget {
  final int points;

  const PlayerPoints({
    Key? key,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.misty,
        child: Column(
          children: [
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
    );
  }
}
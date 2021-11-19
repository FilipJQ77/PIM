import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

class BoardTimer extends StatefulWidget {
  const BoardTimer({Key? key}) : super(key: key);

  @override
  State<BoardTimer> createState() => _BoardTimerState();
}

class _BoardTimerState extends State<BoardTimer> {
  double targetValue = 24.0;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: const Duration(minutes: 3),
        tween: Tween(begin: const Duration(minutes: 4), end: Duration.zero),
        onEnd: () {
          print('Timer ended');
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          String seconds = (value.inSeconds % 60).toString();
          if (seconds.length == 1) {
            seconds = "0" + seconds;
          }
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.timer, size: 30, color: AppColors.purple),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('$minutes:$seconds',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.navyBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ],
              ));
        });
  }
}

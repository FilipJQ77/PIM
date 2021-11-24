import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: const Duration(minutes: 3),
        tween: Tween(begin: const Duration(minutes: 4), end: Duration.zero),
        onEnd: () {
          print('Timer ended'); // todo jakieś kończenie tury
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          String seconds = (value.inSeconds % 60).toString();
          if (seconds.length == 1) {
            seconds = "0" + seconds;
          }
          return Expanded(
            child: Container(
              color: AppColors.mistyWhite,
              child: Column(
                children: <Widget>[
                  const Text("Round Timer",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.timer,
                              size: 30, color: AppColors.purple),
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
                      )),
                ],
              ),
            ),
          );
        });
  }
}

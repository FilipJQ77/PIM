import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/game_over/game_over_buttons.dart';
import 'package:pim_word_builder/classes/player.dart';

const homeContainerDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/HomeBackground_unsplash.jpg"),
      fit: BoxFit.cover,
    ));

class GameOver extends StatelessWidget {
  final List<Player> players;
  GameOver({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Container(
                  decoration: homeContainerDecoration,
                ),
                Container(
                  color: AppColors.transparentGray,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/BabbleMainScreen.png'),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: const Text("Game Over!",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Player 1: ${players[0].points}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Player 2: ${players[1].points}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                        child: const ReturnToMenuButton(),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

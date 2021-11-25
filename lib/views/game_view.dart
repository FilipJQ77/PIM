import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import '../app_colors.dart';
import 'board_view.dart';

class GameView extends StatelessWidget {
  // String playerName1;
  // String playerName2;
  // String playerColor1 = "";
  // String playerColor2 = "";
  const GameView(String playerName1, String playerName2, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColors.purple),
      home: Scaffold(
          appBar: appBar(context),
          body:
              BoardView()), // TODO body powinno byc zbiorem boarda, reki gracza, i guziczkow
    );
  }
}

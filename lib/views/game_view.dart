import 'package:flutter/material.dart';
import 'package:pim_word_builder/widgets/app_bar.dart';
import '../app_colors.dart';
import 'board_view.dart';



class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColors.purple),
      home: Scaffold(
          appBar: appBar(context),
          body: BoardView()), // TODO body powinno byc zbiorem boarda, reki gracza, i guziczkow
    );
  }
}

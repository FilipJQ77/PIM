import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'board_view.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColors.purple),
      home: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/images/BabbleHome.png',
                        color: AppColors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 120,
                  ),
                ],
              )),
          body: BoardView()),
    );
  }
}
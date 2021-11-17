import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pim_word_builder/home_screen.dart';
import 'package:pim_word_builder/board_screen.dart';
import 'package:pim_word_builder/app_colors.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BabbleWords!',
      theme: ThemeData(primarySwatch: AppColors.purple), // AppBar color
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
          body: const BoardScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:pim_word_builder/views/game_view.dart';
import 'package:pim_word_builder/main.dart';
import '../app_colors.dart';
import 'package:pim_word_builder/widgets/home_button.dart';


ButtonStyle myButtonDecoration() {
  return ElevatedButton.styleFrom(
    primary: AppColors.purple,
    onPrimary: AppColors.white,
    shadowColor: AppColors.purple,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    minimumSize: const Size(100, 40),
  );
}


const homeContainerDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/HomeBackground_unsplash.jpg"),
      fit: BoxFit.cover,
    ));

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                      Image.asset('assets/images/BabbleMainScreen.png'),
                      startGameButton(context),
                      rulesButton(context),
                      authorsButton(context),
                      exitButton(),
                    ],
                  ),
                ),
              ],
            )));
  }
}


import 'package:flutter/material.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/home/home_buttons.dart';

const homeContainerDecoration = BoxDecoration(
    image: DecorationImage(
  image: AssetImage("assets/images/HomeBackground_unsplash.jpg"),
  fit: BoxFit.cover,
));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                      Image.asset('assets/images/BabbleMainScreen.png'),
                      const StartGameButton(),
                      const RulesButton(),
                      const AuthorsButton(),
                      const ExitButton(),
                    ],
                  ),
                ),
              ],
            )));
  }
}

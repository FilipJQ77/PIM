import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pim_word_builder/function_button.dart';
import 'package:pim_word_builder/home_screen.dart';
import 'package:pim_word_builder/board.dart';
import 'package:pim_word_builder/hand_letter.dart';
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
      theme: ThemeData(primarySwatch: AppColors.purple),
      //TODO Create our own purple MaterialColor
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

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // BOARD
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                      color: AppColors.misty,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: Board()),
                      )),
                ),
              ],
            ),
          ),
          // HAND
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Row(
                      children: [
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                        HandLetter(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // BUTTONS
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.misty,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FunctionButton(icon: Icons.undo_rounded, text: 'UNDO'),
                        FunctionButton(
                            icon: Icons.change_circle_rounded,
                            text: 'EXCHANGE'),
                        FunctionButton(
                            icon: Icons.shuffle_on_rounded, text: 'SHUFFLE'),
                        FunctionButton(
                            icon: Icons.skip_next_rounded, text: 'PASS'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

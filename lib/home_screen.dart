import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:pim_word_builder/main.dart';
import 'package:pim_word_builder/app_colors.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/HomeBackground_unsplash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
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
              ElevatedButton(
                style: myButtonDecoration(),
                child: const Text('Start Game'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _startPopUp(context),
                  );
                },
              ),
              ElevatedButton(
                style: myButtonDecoration(),
                child: const Text('Rules'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _rulesPopUp(context),
                  );
                },
              ),
              ElevatedButton(
                style: myButtonDecoration(),
                child: const Text('Authors'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _creditsPopUp(context),
                  );
                },
              ),
              ElevatedButton(
                style: myButtonDecoration(),
                child: const Text('Exit'),
                onPressed: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    )));
  }
}

Widget _creditsPopUp(BuildContext context) {
  return AlertDialog(
    title: const Text('BabbleWords! was created by'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text("Maciej Byczko"),
        Text("Filip Przygoński"),
        Text("Filip Sołdon"),
        Text("Jakub Tołściuk"),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close', style: TextStyle(color: AppColors.purple)),
      ),
    ],
  );
}

Widget _rulesPopUp(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'BabbleWords!\nRules',
      textAlign: TextAlign.center,
    ),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text("Description\n", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              "BabbleWords! is a word game in which two players score points by placing tiles, each bearing a single letter, onto a game board divided into a 15×15 grid of squares. The tiles must form words that, in crossword fashion, read `left to right` in rows or `downward` in columns, and be included in a standard dictionary or lexicon."),
          Text("\nGameplay\n", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              "1. The first player combines two or more of his or her letters to form a word and places it on the board to read either across or down with one letter on the center square."),
          Text("Diagonal words are not allowed.\n"),
          Text("2. Complete your turn by clicking End Turn Button.\n"),
          Text(
              "3. Play passes to the next player. The second player, and then each in turn, adds one or more letters to those already played to form new words. All letters played on a turn must be placed in one row across or down the board, to form at least one complete word. If, at the same time, they touch others letters in adjacent rows, those must also form complete words, crossword fashion, with all such letters. The player gets full credit for all words formed or modified on his or her turn."),
          Text("4. New words may be formed by:         "),
          Text(
              "  - Adding one or more letters to a word or letters already on the board."),
          Text(
              "  - Placing a word at right angles to a word already on the board. The new word must use one of the letters already on the board or must add a letter to it.   "),
          Text(
              "  - Placing a complete word parallel to a word already played so that adjacent letters also form complete words."),
          Text("\nBonuses\n", style: TextStyle(fontWeight: FontWeight.bold)),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Red Tiles: ",
                    style: TextStyle(color: AppColors.red)),
                TextSpan(
                  text: 'Word points counts triple   \n',
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Pink Tiles: ",
                    style: TextStyle(color: AppColors.pink)),
                TextSpan(
                  text: "Word points counts double, including star on center\n",
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Dark Blue Tiles: ",
                    style: TextStyle(color: AppColors.darkBlue)),
                TextSpan(
                  text: "Letter on tile counts triple\n",
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "Light Blue Tiles: ",
                    style: TextStyle(color: AppColors.aqua)),
                TextSpan(
                  text: "Letter on tile counts double\n",
                ),
              ],
            ),
          ),
          Text("Each bonus can be used only once,    "),
          Text("The effect of two premium squares are multiplying."),
          Text("\nBINGO!",
              style: TextStyle(
                  color: AppColors.purple, fontWeight: FontWeight.bold)),
          Text(
              "If you play seven tiles on a turn, it's a Bingo. You score a premium of 50 points after totaling our score for the turn.")
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Okay, got it!\n Let's play!",
            style: TextStyle(color: AppColors.purple)),
      ),
    ],
  );
}

Widget _startPopUp(BuildContext context) {
  return AlertDialog(
      title: const Text("Insert players names:"),
      content: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 110,
                child: TextFormField(
                  maxLength: 10,
                  controller: TextEditingController(),
                  textInputAction: TextInputAction.go,
                  // keyboardType: const TextInputType(),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Player 1"),
                ),
              ),
              SizedBox(
                width: 110,
                child: TextFormField(
                  maxLength: 10,
                  controller: TextEditingController(),
                  textInputAction: TextInputAction.go,
                  // keyboardType: const TextInputType(),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Player 2"),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Center(child: DropDownMenu())),
              Expanded(child: Center(child: DropDownMenu())),
            ],
          )
        ],
      ),
      actions: <Widget>[
        Expanded(
          child: Center(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: AppColors.purple)),
                ),
                const Text("Easter egg HAHA",
                    style: TextStyle(color: AppColors.white)),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameScreen()),
                    );
                  },
                  child: const Text(
                    'Start Game!',
                    style: TextStyle(color: AppColors.purple),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
}

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownValue = 'Blue';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Blue', 'Violet', 'Green', 'Orange']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

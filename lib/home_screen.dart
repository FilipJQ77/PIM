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
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0)),
    minimumSize: const Size(100, 40),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage("assets/images/HomeBackground_unsplash.jpg"),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GameScreen()),
                      );
                    },
                  ),
                  ElevatedButton(
                    style: myButtonDecoration(),
                    child: const Text('Options'),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    style: myButtonDecoration(),
                    child: const Text('Authors'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _creditsPopUp(context),
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
        child:
            const Text('Close', style: TextStyle(color: AppColors.purple)),
      ),
    ],
  );
}

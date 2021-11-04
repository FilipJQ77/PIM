import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:pim_word_builder/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        //TODO Create our own purple MaterialColor
        home: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/HomeBackground_unsplash.jpg"), fit: BoxFit.cover,),
                ),
              ),
              Container(
                color: const Color.fromRGBO(255, 255, 255, 0.4),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/BabbleMainScreen.png'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text('Start Game'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const App()),
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text('Options'),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text('Authors'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _creditsPopUp(context),
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: const Size(100, 40),
                      ),
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
          )
        ));
  }
}

Widget _creditsPopUp(BuildContext context) {
  return AlertDialog(
    title: const Text('BabbleWord! was created by'),
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
        child: const Text('Close'),
      ),
    ],
  );
}
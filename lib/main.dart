import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return const MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Hello, my app"),
        // ),
        body: Button(),
      ),
    );
  }
}

class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Center(
        // widthFactor: double.infinity,
        child: Row(
      children: [
        for (var i = 0; i < 6; i++)
          Column(
            children: [
              for (var i = 0; i < 17; i++)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(10, 100, 10, 50),
                    elevation: 10,

                    // shape:
                    // padding: 0,
                    // elevation: 5,
                    // color: Color.fromRGBO(10, 10, 10, 10)
                  ),
                  onPressed: () {},
                  child: Text(i.toString()),
                ),
            ],
          ),
      ],
    ));
  }
}

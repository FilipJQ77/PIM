import 'package:flutter/material.dart';
import 'package:pim_word_builder/parameters.dart';

class FunctionButton extends StatefulWidget {
  final IconData icon;
  final String text;
  //final Function onPressed;
  const FunctionButton({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  _FunctionButtonState createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          primary: SetColor.purple,
          onPrimary: SetColor.white,
          shadowColor: SetColor.lightGreen),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(widget.icon, size: 30.0),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        //widget.onPressed();
      },
    );
  }
}

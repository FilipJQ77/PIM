import 'package:flutter/material.dart';

class ChooseColorDropDown extends StatefulWidget {
  const ChooseColorDropDown({Key? key}) : super(key: key);

  @override
  State<ChooseColorDropDown> createState() => _ChooseColorDropDownState();
}

class _ChooseColorDropDownState extends State<ChooseColorDropDown> {
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

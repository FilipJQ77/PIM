import 'package:flutter/material.dart';

class TextInputBox extends StatelessWidget {
  final String hintText;

  const TextInputBox({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: TextFormField(
        maxLength: 10,
        controller: TextEditingController(),
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), hintText: hintText),
      ),
    );
  }
}

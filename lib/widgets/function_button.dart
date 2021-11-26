import 'package:flutter/material.dart';
import 'package:pim_word_builder/app_colors.dart';
import 'package:pim_word_builder/views/board_view.dart';
import 'package:pim_word_builder/widgets/board.dart';

// todo w sumie to chyba bedzie stateless? w sensie raz mu przypiszemy
// ikone, tekst, funkcje, i to sie nie bedzie zmieniac
class FunctionButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final GlobalKey<BoardState> boardStateRef;

  void undo() {
    // lastClickedLetter = letter;
    print("Clicked undo button");
  }
  //final Function onPressed;
  FunctionButton({Key? key, required this.icon, required this.text, required this.boardStateRef})
      : super(key: key);

  @override
  _FunctionButtonState createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(88, 50),
          maximumSize: const Size(88, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          primary: AppColors.purple,
          onPrimary: AppColors.white,
          shadowColor: AppColors.purple),
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
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        // TODO maybe change this conception
        if(widget.text == 'UNDO') {
          if(widget.boardStateRef.currentState!.getLastClickedLetterXCoords().isEmpty){
            print("LastClickedLetterX/yCoords List is empty");
            return;
          }
          widget.boardStateRef.currentState!.removeLetterFromBoard(
              widget.boardStateRef.currentState!.getLastClickedLetterXCoords().removeLast(),
              widget.boardStateRef.currentState!.getLastClickedLetterYCoords().removeLast());
        }
      },
    );
  }
}

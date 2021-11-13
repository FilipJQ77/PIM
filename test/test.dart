import 'package:pim_word_builder/utils.dart';

void getWordsFromFileTest() {
  var words = Utils.getWordsFromFile("assets/data/wordsGB.txt");
  assert(words.isNotEmpty);
}

void main() {
  getWordsFromFileTest();
}


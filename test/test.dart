import 'package:flutter_test/flutter_test.dart';
import 'package:pim_word_builder/classes/utils.dart';

void getWordsFromFileTest() async {}

void main() {
  group('Utils', () {
    test('Get words from file should have some words', () async {
      var words = await Utils.getWordsFromFile("assets/data/wordsGB.txt");
      expect(words.isNotEmpty, true);
    });
  });
}

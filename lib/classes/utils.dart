import 'dart:io' as io;

import 'dart:math';

class Utils {
  static final Random _random = Random();

  // [min, max)
  static int randomInt(int min, int max) {
    return min + _random.nextInt(max - min);
  }

  static Future<List<String>> getWordsFromFile(String filepath) {
    return io.File(filepath).readAsLines();
  }
}

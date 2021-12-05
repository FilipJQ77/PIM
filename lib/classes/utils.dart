import 'dart:io' as io;
import 'dart:math';

/// Class with helper methods to use anywhere.
class Utils {
  /// [Random] class instance.
  static final Random _random = Random();

  /// Returns a random integer in the range
  /// from [min] inclusive to [max] exclusive.
  static int randomInt(int min, int max) {
    return min + _random.nextInt(max - min);
  }

  /// Asynchronous function that returns
  /// all the words from a file at [filepath].
  static Future<List<String>> getWordsFromFile(String filepath) {
    return io.File(filepath).readAsLines();
  }
}

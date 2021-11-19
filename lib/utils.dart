import 'dart:io' as io;

class Utils {
  static Future<List<String>> getWordsFromFile(String filepath) {
    return io.File(filepath).readAsLines();
  }
}

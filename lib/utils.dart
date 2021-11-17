import 'dart:io';

class Utils {
  static List<String> getWordsFromFile(String filepath) {
    return File(filepath).readAsLinesSync(); // TODO asynchronous in future
  }
}

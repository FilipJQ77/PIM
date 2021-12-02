import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pim_word_builder/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MaterialApp(
    title: 'BabbleWords!',
    home: Home(),
  ));
}

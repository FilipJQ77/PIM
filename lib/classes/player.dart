import 'package:flutter/cupertino.dart';
import 'package:pim_word_builder/classes/app_colors.dart';
import 'package:pim_word_builder/widgets/game/hand_letter.dart';

/// Player class.
class Player {
  /// Player's name.
  final String _name;

  /// [_name] getter.
  String get name => _name;

  /// The color that represents the active player.
  static const Color _activeColor = AppColors.red;

  /// Color chosen by the player to represent them.
  /// Currently simply set to [AppColors.purple].
  /// However in the future a player should be able to choose their color.
  final Color _chosenColor = AppColors.purple;

  /// Current player color.
  ///
  /// When the player has their turn, ([active] == true) their color changes
  /// to [_activeColor]. When their turn is over, it goes back to their
  /// [_chosenColor].
  Color _color = AppColors.purple;

  /// [_color] getter.
  Color get color => _color;

  /// Current player points.
  int _points = 0;

  /// [_points] getter.
  int get points => _points;

  /// If true, the player has their turn. False otherwise.
  bool _active = false;

  /// [_active] getter.
  bool get active => _active;

  /// Current letters the player has in their hand.
  final List<HandLetter> _letters;

  /// [_letters] getter.
  /// TODO probably remove access to this and create functions in the future.
  List<HandLetter> get letters => _letters;

  Player(this._name, this._letters);

  /// Add [points] to player.
  void addPoints(int points) {
    _points += points;
  }

  /// Toggle player turn.
  void toggleActive() {
    _active = !_active;
    if (active) {
      _color = _activeColor;
    } else {
      _color = _chosenColor;
    }
  }
}

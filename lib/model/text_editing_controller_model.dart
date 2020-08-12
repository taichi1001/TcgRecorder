import 'package:flutter/material.dart';

class TextEditingControllerModel with ChangeNotifier {
  TextEditingController _gameController;
  TextEditingController get gameController => _gameController;
  set gameController(value) {
    _gameController = value;
    notifyListeners();
  }

  TextEditingController _tagController;
  TextEditingController get tagController => _tagController;
  set tagController(value) {
    _tagController = value;
    notifyListeners();
  }

  TextEditingController _useDeckController;
  TextEditingController get useDeckController => _useDeckController;
  set useDeckController(value) {
    _useDeckController = value;
    notifyListeners();
  }

  TextEditingController _opponentDeckController;
  TextEditingController get opponentDeckController => _opponentDeckController;
  set opponentDeckController(value) {
    _opponentDeckController = value;
    notifyListeners();
  }
}

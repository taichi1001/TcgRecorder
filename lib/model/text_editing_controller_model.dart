import 'package:flutter/material.dart';

class TextEditingControllerModel with ChangeNotifier {
  TextEditingController gameController;
  void setGameController(value) {
    gameController = value;
   notifyListeners();
  }

  TextEditingController tagController;
  void setTagController(value) {
    tagController = value;
   notifyListeners();
  }

  TextEditingController useDeckController;
  void setUseDeckController(value) {
    useDeckController = value;
   notifyListeners();
  }

  TextEditingController opponentDeckController;
  void setOpponentDeckController(value) {
    opponentDeckController = value;
   notifyListeners();
  }
}

import 'package:flutter/material.dart';

class TextEditingControllerModel with ChangeNotifier {
  TextEditingController gameController = TextEditingController();
  void setGameController(String value) {
    gameController.text = value;
    notifyListeners();
  }

  TextEditingController tagController;
  void setTagController(TextEditingController value) {
    tagController = value;
    notifyListeners();
  }

  TextEditingController useDeckController;
  void setUseDeckController(TextEditingController value) {
    useDeckController = value;
    notifyListeners();
  }

  TextEditingController opponentDeckController;
  void setOpponentDeckController(TextEditingController value) {
    opponentDeckController = value;
    notifyListeners();
  }
}

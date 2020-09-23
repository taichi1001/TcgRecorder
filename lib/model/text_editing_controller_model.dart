import 'package:flutter/material.dart';

class TextEditingControllerModel with ChangeNotifier {
  TextEditingController gameController = TextEditingController();
  void setGameController(String value) {
    gameController.text = value;
    notifyListeners();
  }

  TextEditingController tagController = TextEditingController();
  void setTagController(String value) {
    tagController.text = value;
    notifyListeners();
  }

  TextEditingController useDeckController = TextEditingController();
  void setUseDeckController(String value) {
    useDeckController.text = value;
    notifyListeners();
  }

  TextEditingController opponentDeckController = TextEditingController();
  void setOpponentDeckController(String value) {
    opponentDeckController.text = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class LoadingIndicator extends ChangeNotifier {
  bool _isVisible = false;
  String? _message;

  bool get isVisible => _isVisible;
  String? get message => _message;

  void show([String? message]) {
    _isVisible = true;
    _message = message;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    _message = null;
    notifyListeners();
  }

  void updateMessage(String message) {
    _message = message;
    notifyListeners();
  }
}

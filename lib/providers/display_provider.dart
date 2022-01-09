import 'package:flutter/material.dart';
import 'package:local_resturant/screens/home.dart';

class AppDisplayProvider extends ChangeNotifier {
  Widget _display = HomePage();

  changeTo(Widget body) {
    _display = body;
    notifyListeners();
  }

  Widget get body => _display;
}

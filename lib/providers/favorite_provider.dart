import 'package:flutter/material.dart';
import 'package:local_resturant/models/food.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Food> _favList = [];

  int isFavorite(Food food) {
    for (var i = 0; i < _favList.length; i++) {
      var item = _favList[i];
      if ("${item.id}" == "${food.id}") {
        return i; //true
      }
    }
    return -1; //false
  }

  void toggleFav(Food food) {
    var id = isFavorite(food);
    if (id == -1) {
      _favList.add(food);
    } else {
      _favList.removeAt(id);
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:local_resturant/models/food.dart';

class CartProvider extends ChangeNotifier {
  final List<Food> _items = [];

  List<Food> get items => _items;

  int getCartItemLenght() => _items.length;

  double get totalPrice {
    var price = 0.0;
    for (var item in _items) {
      price += item.quantity * item.price;
    }
    return price;
  }

  void addRemoveFood(Food food) {
    var index = cartHasFood(food);
    if (index == -1) {
      food.quantity = 1;
      _items.add(food);
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  int cartHasFood(Food food) {
    for (var i = 0; i < _items.length; i++) {
      var item = _items[i];
      if ("${item.id}" == "${food.id}") {
        return i;
      }
    }
    return -1;
  }

  int getFoodQuantity(Food food) {
    var index = cartHasFood(food);
    if (index > -1) {
      return _items[index].quantity;
    }
    return -1;
  }

  incDecFoodQuantity(Food food, {isIncrease: true}) {
    var index = cartHasFood(food);
    var item = _items[index];
    item.quantity = isIncrease ? item.quantity + 1 : item.quantity - 1;
    notifyListeners();
  }
}

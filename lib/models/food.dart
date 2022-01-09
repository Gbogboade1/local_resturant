import 'package:flutter/material.dart';

class Food {
  String id;
  String image;
  String name;
  String description;
  bool isFave;
  double price;
  int quantity;

  Food({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.description,
    @required this.isFave,
    @required this.price,
    this.quantity: 1,
  });
}

import 'package:flutter/material.dart';
import 'package:local_resturant/values/color.dart';

Widget quantityButton({IconData icon, onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Icon(
          // Icons.add,
          icon,
          color: mainBlue,
        ),
      ),
    ),
  );
}

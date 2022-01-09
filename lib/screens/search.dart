import 'package:flutter/material.dart';
import 'package:local_resturant/models/food.dart';
import 'package:local_resturant/widget/foodItem.dart';

class Searchscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Search',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Product Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(4.0),
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: .75,
                ),
                children: List.generate(
                  10,
                  (index) => FoodItem(
                    Food(
                      id: UniqueKey().toString(),
                      image: 'images/Salmon_Sushi.png',
                      name: 'Salmon Sushi',
                      description:
                          'Salmon, carrot rolls, spinach and some sauce.',
                      isFave: false,
                      price: 28.00,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
